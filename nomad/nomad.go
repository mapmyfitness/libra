package nomad

import (
	"errors"
	"os"
	"strconv"

	api "github.com/hashicorp/nomad/api"
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
func Scale(client *api.Client, jobID, group string, scale, min, max int) (string, int, error) {
	job, _, err := client.Jobs().Info(jobID, &api.QueryOptions{})
	newCount := -1
	if err != nil {
		return "", 0, err
	}
	for _, tg := range job.TaskGroups {
		if *tg.Name == group {
			oldCount := *tg.Count
			newCount = oldCount + scale
			if newCount < min || newCount > max {
				return "", oldCount, errors.New("the new group count (" + strconv.Itoa(newCount) + ") is outside of the configured range (" + strconv.Itoa(min) + "-" + strconv.Itoa(max) + ")")
			}
			tg.Count = &newCount
		}
	}
	if newCount > -1 {
		resp, _, _ := client.Jobs().Register(job, &api.WriteOptions{})
		return resp.EvalID, newCount, nil
	} else {
		return "", -1, errors.New("could not find task group " + group + " in job " + jobID)
	}
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
	oldCount := *job.TaskGroups[0].Count
	if count < min || count > max {
		return "", oldCount, errors.New("the desired count (" + strconv.Itoa(count) + ") is outside of the configured range (" + strconv.Itoa(min) + "-" + strconv.Itoa(max) + ")")
	}
	job.TaskGroups[0].Count = &count
	resp, _, _ := client.Jobs().Register(job, &api.WriteOptions{})
	return resp.EvalID, count, nil
}
