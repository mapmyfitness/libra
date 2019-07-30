package api

import (
	"net/http"
	"os"

	"github.com/ant0ine/go-json-rest/rest"
	log "github.com/sirupsen/logrus"
	"github.com/YotpoLtd/libra/config"
	"github.com/YotpoLtd/libra/nomad"
)

func CapacityHandler(w rest.ResponseWriter, r *rest.Request) {
	var t ScaleRequest
	err := r.DecodeJsonPayload(&t)
	if err != nil {
		log.Errorln(err)
		rest.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	defer r.Body.Close()
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

	configGroup := config.Jobs[t.Job].Groups[t.Group]
	evalID, newCount, err := nomad.SetCapacity(n, t.Job, t.Group, t.Count, configGroup.MinCount, configGroup.MaxCount)
	if err != nil {
		log.Error("Problem scaling the task group " + err.Error())
		rest.Error(w, err.Error(), http.StatusInternalServerError)
	} else {
		log.Infof("Set capacity of %s/%s to %d! Evaluation %s", t.Job, t.Group, t.Count, evalID)
		w.WriteHeader(http.StatusOK)
		w.Header().Set("Content-Type", "application/json; charset=UTF-8")
		respBody := &ScaleResponse{
			Eval:     evalID,
			NewCount: newCount,
		}

		w.WriteJson(respBody)
	}
}
