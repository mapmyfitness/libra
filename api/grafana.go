package api

import (
	"encoding/json"
	"net/http"
	"os"

	"github.com/ant0ine/go-json-rest/rest"
	log "github.com/sirupsen/logrus"
	"github.com/underarmour/libra/config"
	"github.com/underarmour/libra/nomad"
)

type GrafanaRequest struct {
	Title       string               `json:"title"`
	State       string               `json:"state"`
	Count       int                  `json:"count"`
	Message     string               `json:"message"`
	EvalMatches []GrafanaEvalMatches `json:"evalMatches"`
}

type GrafanaEvalMatches struct {
	Metric string  `json:"metric"`
	Value  float64 `json:"value"`
}

type GrafanaMessageBody struct {
	Job            string  `json:"job"`
	Group          string  `json:"group"`
	MinCount       int     `json:"min_count"`
	MaxCount       int     `json:"max_count"`
	MaxThreshold   float64 `json:"max_threshold"`
	MinThreshold   float64 `json:"min_threshold"`
	MaxAction      string  `json:"max_action"`
	MinAction      string  `json:"min_action"`
	MaxActionCount int     `json:"min_action_count"`
	MinActionCount int     `json:"max_action_count"`
}

func GrafanaHandler(w rest.ResponseWriter, r *rest.Request) {
	var t GrafanaRequest
	err := r.DecodeJsonPayload(&t)
	if err != nil {
		log.Errorln(err)
		rest.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	defer r.Body.Close()

	var mb GrafanaMessageBody
	log.Infof("MESSAGE BODY: %s", t.Message)
	if err := json.Unmarshal([]byte(t.Message), &mb); err != nil {
		log.Errorf("Problem parsing Grafana webhook json %s: %s", t.Message, err)
		rest.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	log.Infof("MESSAGE BODY JOB: %s", mb.Job)
	config, err := config.NewConfig(os.Getenv("LIBRA_CONFIG_DIR"))
	if err != nil {
		log.Errorf("Failed to read or parse config file: %s", err)
		rest.Error(w, err.Error(), http.StatusInternalServerError)
	}
	log.Info("Loaded and parsed configuration file")
	n, err := nomad.NewClient(config.Nomad)
	if err != nil {
		log.Errorf("Failed to create Nomad Client: %s", err)
		rest.Error(w, err.Error(), http.StatusInternalServerError)
	}
	log.Info("Successfully created Nomad Client")

	var amount int
	// TODO: Right now this only grabs the first match. Really, we should take all of them and average them together
	if t.EvalMatches[0].Value < mb.MinThreshold {
		amount = mb.MinActionCount
	} else if t.EvalMatches[0].Value > mb.MaxThreshold {
		amount = -mb.MaxActionCount
	} else {
		w.WriteHeader(http.StatusOK)
		return
	}

	evalID, newCount, err := nomad.Scale(n, mb.Job, mb.Group, amount, mb.MinCount, mb.MaxCount)
	if err != nil {
		log.Error("Problem scaling the task group " + err.Error())
		rest.Error(w, err.Error(), http.StatusInternalServerError)
	} else {
		log.Infoln("Scaled it! Evaluation " + evalID)
		w.WriteHeader(http.StatusOK)
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")
		respBody := &ScaleResponse{
			Eval:     evalID,
			NewCount: newCount,
		}

		w.WriteJson(respBody)
	}
}
