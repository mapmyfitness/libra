package backend

import (
	"errors"
	"fmt"

	log "github.com/sirupsen/logrus"
	"github.com/YotpoLtd/libra/graphite"
	"github.com/YotpoLtd/libra/structs"
)

// GraphiteConfig is the configuration for a Graphite backend
type GraphiteConfig struct {
	Name     string
	Kind     string
	Host     string
	Username string
	Password string
}

// GraphiteBackend is a metrics backend
type GraphiteBackend struct {
	Name       string
	Config     GraphiteConfig
	Connection *graphite.Client
}

// NewGraphiteBackend will create a new Graphite Client
func NewGraphiteBackend(name string, config GraphiteConfig) (*GraphiteBackend, error) {
	sess := graphite.NewClient(config.Host, config.Username, config.Password)

	backend := &GraphiteBackend{}
	backend.Name = name
	backend.Config = config
	backend.Connection = sess

	return backend, nil
}

// GetValue gets a value
func (b *GraphiteBackend) GetValue(rule structs.Rule) (float64, error) {
	metricName := rule.MetricName
	if metricName == "" {
		return 0.0, fmt.Errorf("Missing metric_name inside config{} stanza")
	}

	s, err := b.Connection.Render(metricName)
	if err != nil {
		log.Println(err)
		return 0.0, err
	}
	if len(s.Datapoints) == 0 {
		return 0.0, errors.New("no datapoints found for metric")
	}
	return s.Datapoints[len(s.Datapoints)-1][0], nil
}

func (b *GraphiteBackend) Info() *structs.Backend {
	return &structs.Backend{
		Kind: b.Config.Kind,
		Name: b.Name,
	}
}
