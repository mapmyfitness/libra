package nomad

import (
	"errors"
	"log"
	"os"
	"strconv"
	"strings"

	consulapi "github.com/hashicorp/consul/api"
	"github.com/hashicorp/nomad/api"
	"github.com/hashicorp/nomad/nomad/structs"
	_ "github.com/ugorji/go/codec"
)

// NewClient will create a instance of a nomad API Client
func NewClient(c Config) (*api.Client, error) {
	nomadDefaultConfig := api.DefaultConfig()
	envAddress := os.Getenv("NOMAD_ADDRESS")

	if envAddress != "" {
		nomadDefaultConfig.Address = envAddress
	} else {
		nomadDefaultConfig.Address = c.Address
	}

	client, err := api.NewClient(nomadDefaultConfig)
	if err != nil {
		return nil, err
	}

	return client, nil
}

// Scale increases or decreases the count of a task group
// Returns EvaluationID (string), New Count (int), Error
func Scale(client *api.Client, jobID, group string, scale, min, max int) (string, int, error) {

	jobDeploymentStatus, _, err := client.Jobs().Deployments(jobID, &api.QueryOptions{})
	if err != nil {
		log.Printf("[ERROR] Failed to list deployments for job %s", jobID)
		return "", 0, err
	}

	if len(jobDeploymentStatus) != 0 {
		if jobDeploymentStatus[0].Status == structs.DeploymentStatusRunning {
			log.Printf("[INFO] Job %s has active deployment (%s) running, skipping Scale", jobID, jobDeploymentStatus[0].ID)
			return "", 0, nil
		}
	}

	job, _, err := client.Jobs().Info(jobID, &api.QueryOptions{})
	if err != nil {
		return "", 0, err
	}

	var newCount int
	newCount = 0
	var groupName string

	for _, tg := range job.TaskGroups {
		groupName = *tg.Name
		if *tg.Name == group {
			oldCount := *tg.Count
			if *job.Status == "dead" {
				if scale > 0 {
					newCount = scale
					desiredJobStopStatus := false

					job.Stop = &desiredJobStopStatus
					log.Printf("[DEBUG] Bringing %s back to live", *job.Name)
				}
			} else {
				newCount = oldCount + scale
			}
			if newCount > max {
				log.Printf("[DEBUG] New count %d for %s/%s is bigger then max [%d], using max", newCount, *job.Name, *tg.Name, max)
				newCount = max
			}
			if newCount < min {
				log.Printf("[DEBUG] New count %d for %s/%s is smaller then min [%d], using min", newCount, *job.Name, *tg.Name, min)
				newCount = min
			}
			if oldCount == newCount {
				if *job.Status != "dead" { // Checking if we didn't bring the job back to live
					log.Printf("[DEBUG] New count %d for %s/%s is equal to current", newCount, *job.Name, *tg.Name)
					return "", newCount, nil
				}
			}
			tg.Count = &newCount
		}
	}

	resp, _, err := client.Jobs().Register(job, &api.WriteOptions{})
	if err != nil {
		return "", 0, err
	}
	consulKeyBase := exportConsulKeyBase(jobID, groupName)
	consulKey := os.Getenv("CONSUL_KEY_PREFIX") + "/" + consulKeyBase + "/counts/" + groupName + "/" + os.Getenv("CONSUL_KEY")

	newCountString := strconv.Itoa(newCount)
	consulWriteToKV(consulKey, newCountString)
	return resp.EvalID, newCount, err
}

// Restart restarts a job to get the latest docker image
func Restart(client *api.Client, jobID, group, task, image string) (string, error) {
	found := false
	job, _, err := client.Jobs().Info(jobID, &api.QueryOptions{})
	if err != nil {
		return "", err
	}
	for _, tg := range job.TaskGroups {
		if *tg.Name == group || group == "any" {
			for _, t := range tg.Tasks {
				if t.Name == task || task == "any" {
					t.Config["image"] = image
					found = true
				}
			}
		}
	}
	if found {
		resp, _, err := client.Jobs().Register(job, &api.WriteOptions{})
		if err != nil {
			return "", err
		}
		return resp.EvalID, nil
	} else {
		return "", errors.New("could not find task group " + group + " in job " + jobID)
	}
}

// SetCapacity sets the count of a task group
func SetCapacity(client *api.Client, jobID, groupID string, count, min, max int) (string, int, error) {
	job, _, err := client.Jobs().Info(jobID, &api.QueryOptions{})
	if err != nil {
		return "", 0, err
	}

	if *job.Status == "dead" {
		log.Printf("[DEBUG] job %s is dead, setting count to 1 and state to running", *job.Name)
		count = 1
	} else {
		// TODO: fix GroupID
		oldCount := *job.TaskGroups[0].Count
		if count < min || count > max {
			return "", oldCount, errors.New("the desired count (" + strconv.Itoa(count) + ") is outside of the configured range (" + strconv.Itoa(min) + "-" + strconv.Itoa(max) + ")")
		}
	}

	desiredJobStopStatus := false

	job.Stop = &desiredJobStopStatus
	job.TaskGroups[0].Count = &count
	resp, _, _ := client.Jobs().Register(job, &api.WriteOptions{})
	return resp.EvalID, count, nil
}

func exportConsulKeyBase(jobID string, groupName string) string {
	replaced := strings.Replace(jobID, "-"+groupName, "", -1)
	return replaced
}

func consulWriteToKV(consulKey string, consulValue string) {

	// Get a new client
	log.Printf("[INFO] Saving value %s in consul %s", consulValue, consulKey)

	config := consulapi.DefaultConfig()
	config.Address = os.Getenv("CONSUL_ADDRESS")
	client, err := consulapi.NewClient(config)

	if err != nil {
		log.Printf("[ERROR] New Client config  %s", err.Error())
	}

	// Get a handle to the KV API
	kv := client.KV()

	// PUT a new KV pair
	p := &consulapi.KVPair{Key: consulKey, Value: []byte(consulValue)}
	_, err = kv.Put(p, nil)
	if err != nil {
		log.Printf("[ERROR] KVPair pust  %s", err.Error())

	}
}
