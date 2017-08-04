package api

import (
	"encoding/json"
	"net/http"

	"github.com/ant0ine/go-json-rest/rest"
	log "github.com/sirupsen/logrus"
)

type GrafanaRequest struct {
	Title       string             `json:"title"`
	State       string             `json:"state"`
	Count       int                `json:"count"`
	Message     string             `json:"message"`
	EvalMatches GrafanaEvalMatches `json:"evalMatches"`
}

type GrafanaEvalMatches struct {
	Metric string  `json:"metric"`
	Value  float64 `json:"value"`
}

type GrafanaMessageBody struct {
	Job   string `json:"job"`
	Group string `json:"group"`
	Count int    `json:"count"`
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
	if err := json.Unmarshal([]byte(t.Message), &mb); err != nil {
		log.Errorln(err)
		rest.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	log.Infof("MESSAGE BODY JOB: %s", mb.Job)
	// config, err := config.NewConfig(os.Getenv("LIBRA_CONFIG_DIR"))
	// if err != nil {
	// 	log.Errorf("Failed to read or parse config file: %s", err)
	// 	rest.Error(w, err.Error(), http.StatusInternalServerError)
	// }
	// log.Info("Loaded and parsed configuration file")
	// n, err := nomad.NewClient(config.Nomad)
	// if err != nil {
	// 	log.Errorf("Failed to create Nomad Client: %s", err)
	// 	rest.Error(w, err.Error(), http.StatusInternalServerError)
	// }
	// log.Info("Successfully created Nomad Client")

	// if t.Count == 0 {
	// 	log.Error("Amount to increment or decrement cannot be 0.")
	// 	rest.Error(w, err.Error(), http.StatusInternalServerError)
	// }
	// configGroup := config.Jobs[t.Job].Groups[t.Group]
	// evalID, newCount, err := nomad.Scale(n, t.Job, t.Group, t.Count, configGroup.MinCount, configGroup.MaxCount)
	// if err != nil {
	// 	log.Error("Problem scaling the task group " + err.Error())
	// 	rest.Error(w, err.Error(), http.StatusInternalServerError)
	// } else {
	// 	log.Infoln("Scaled it! Evaluation " + evalID)
	// 	w.WriteHeader(http.StatusOK)
	// 	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	// 	respBody := &ScaleResponse{
	// 		Eval:     evalID,
	// 		NewCount: newCount,
	// 	}

	// 	w.WriteJson(respBody)
	// }
}
