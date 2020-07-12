package backend

import (
	"fmt"
	"github.com/YotpoLtd/libra/structs"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/common/model"
	"time"
)

// PrometheusConfig is the configuration for a Prometheus backend
type PrometheusConfig struct {
	Name string
	Kind string
	Host string
}

// PrometheusBackend is a metrics backend
type PrometheusBackend struct {
	Name       string
	Config     PrometheusConfig
	Connection prometheus.QueryAPI
}

func NewQueryAPI(address string) (prometheus.QueryAPI, error) {
	cfg := prometheus.Config{
		Address: address,
	}

	client, err := prometheus.New(cfg)
	if err != nil {
		return nil, err
	}

	return prometheus.NewQueryAPI(client), nil
}

// NewPrometheusBackend will create a new Prometheus Client
func NewPrometheusBackend(name string, config PrometheusConfig, queryApi prometheus.QueryAPI) (*PrometheusBackend, error) {
	backend := &PrometheusBackend{}
	backend.Name = name
	backend.Config = config
	backend.Connection = queryApi

	return backend, nil
}

// GetValue gets a value
func (b *PrometheusBackend) GetValue(rule structs.Rule) (float64, error) {
	metricName := rule.MetricName
	if metricName == "" {
		return 0.0, fmt.Errorf("Missing metric_name inside config{} stanza")
	}

	value, err := b.Connection.Query(context.Background(), metricName, time.Now())
	if err != nil {
		return 0.0, err
	}

	if value.Type() != model.ValVector {
		return 0.0, fmt.Errorf("metric '%s' is not a vector", metricName)
	}

	s, ok := value.(model.Vector)
	if !ok {
		return 0.0, fmt.Errorf("failed to cast '%s' to vector", metricName)
	}

	if s.Len() > 1 {
		return 0.0, fmt.Errorf("metric '%s' is not an instant vector", metricName)
	}

	return float64([]*model.Sample(s)[0].Value), nil
}

func get(a []*model.Sample, index int) *model.Sample {
	return a[index]
}

func (b *PrometheusBackend) Info() *structs.Backend {
	return &structs.Backend{
		Kind: b.Config.Kind,
		Name: b.Name,
	}
}