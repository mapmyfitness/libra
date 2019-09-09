package api

import (
	"net/http"

	"os"

	"github.com/ant0ine/go-json-rest/rest"
	log "github.com/sirupsen/logrus"
	"github.com/YotpoLtd/libra/backend"
	"github.com/YotpoLtd/libra/config"
)

type BackendResponse struct {
	Name string `json:"name"`
	Kind string `json:"kind"`
}

func BackendsHandler(w rest.ResponseWriter, r *rest.Request) {
	config, err := config.NewConfig(os.Getenv("LIBRA_CONFIG_DIR"))
	if err != nil {
		log.Errorf("Failed to read or parse config file: %s", err)
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	log.Info("Loaded and parsed configuration file")
	backends, err := backend.InitializeBackends(config.Backends)
	if err != nil {
		log.Errorf("Failed to get backends: %s", err)
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	backendResponses := []BackendResponse{}
	for _, bv := range backends {
		newBV := BackendResponse{
			Name: bv.Info().Name,
			Kind: bv.Info().Kind,
		}
		backendResponses = append(backendResponses, newBV)
	}

	if err != nil {
		log.Errorf("Problem getting backends: %s", err.Error())
		rest.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.WriteJson(backendResponses)
}
