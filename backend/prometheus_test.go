package backend_test

import (
	"context"
	"fmt"
	"github.com/prometheus/client_golang/api/prometheus"
	"github.com/prometheus/common/model"
	"github.com/underarmour/libra/backend"
	"github.com/underarmour/libra/structs"
	"testing"
	"time"
)

type mockQueryApi struct {
	query func(ctx context.Context, query string, ts time.Time) (model.Value, error)
	queryRange func(ctx context.Context, query string, r prometheus.Range) (model.Value, error)
}

func (qa *mockQueryApi) Query(ctx context.Context, query string, ts time.Time) (model.Value, error) {
	return qa.query(ctx, query, ts)
}

func (qa *mockQueryApi) QueryRange(ctx context.Context, query string, r prometheus.Range) (model.Value, error)	{
	return qa.queryRange(ctx, query, r)
}



func TestNewPrometheusBackend(t *testing.T) {
	qa := &mockQueryApi{}

	name := "test"
	config := backend.PrometheusConfig{
		Name: name,
		Kind: "prometheus",
		Host: "localhost",
	}

	b, err := backend.NewPrometheusBackend(name, config, qa)
	if err != nil {
		t.Fail()
	}

	if b.Name != name {
		t.Fail()
	}

	if b.Connection == nil {
		t.Fail()
	}
}

func TestPrometheusBackend_GetValue(t *testing.T) {
	name := "test"
	kind := "prometheus"
	host := "localhost"
	config := backend.PrometheusConfig{
		Name: name,
		Kind: kind,
		Host: host,
	}

	qa := &mockQueryApi{
		query: func(ctx context.Context, query string, ts time.Time) (model.Value, error) {
			return model.Vector{
				&model.Sample{
					Value: 127.0,
				},
			}, nil
		},
	}

	b, err := backend.NewPrometheusBackend(name, config, qa)
	if err != nil {
		t.Fail()
	}

	value, err := b.GetValue(structs.Rule{
		MetricName: "test",
	})
	fmt.Print(value, err)
	if err != nil {
		t.Fail()
	}
	if value != 127.0 {
		t.Fail()
	}
}



func TestPrometheusBackend_GetValue_EmptyMetricName(t *testing.T) {
	name := "test"
	kind := "prometheus"
	host := "localhost"
	config := backend.PrometheusConfig{
		Name: name,
		Kind: kind,
		Host: host,
	}

	qa := &mockQueryApi{}

	b, err := backend.NewPrometheusBackend(name, config, qa)
	if err != nil {
		t.Fail()
	}

	_, err = b.GetValue(structs.Rule{
		MetricName: "",
	})

	if err.Error() != "Missing metric_name inside config{} stanza" {
		t.Fail()
	}
}

func TestPrometheusBackend_GetValue_StringMetric(t *testing.T) {
	name := "test"
	kind := "prometheus"
	host := "localhost"
	config := backend.PrometheusConfig{
		Name: name,
		Kind: kind,
		Host: host,
	}

	qa := &mockQueryApi{
		query: func(ctx context.Context, query string, ts time.Time) (model.Value, error) {
			return model.Vector{
				&model.Sample{
					Value: 127.0,
				},
				&model.Sample{
					Value: 256.0,
				},
			}, nil
		},
	}

	b, err := backend.NewPrometheusBackend(name, config, qa)
	if err != nil {
		t.Fail()
	}

	_, err = b.GetValue(structs.Rule{
		MetricName: "test",
	})
	if err.Error() == "metric test is not a vector" {
		t.Fail()
	}
}


func TestPrometheusBackend_GetValue_RangeVector(t *testing.T) {
	name := "test"
	kind := "prometheus"
	host := "localhost"
	config := backend.PrometheusConfig{
		Name: name,
		Kind: kind,
		Host: host,
	}

	qa := &mockQueryApi{
		query: func(ctx context.Context, query string, ts time.Time) (model.Value, error) {
			return &model.String{
				Value: "127.0",
			}, nil
		},
	}

	b, err := backend.NewPrometheusBackend(name, config, qa)
	if err != nil {
		t.Fail()
	}

	_, err = b.GetValue(structs.Rule{
		MetricName: "test",
	})
	if err.Error() == "metric test is not a vector" {
		t.Fail()
	}
}


func TestPrometheusBackend_Info(t *testing.T) {
	qa := &mockQueryApi{}

	name := "test"
	kind := "prometheus"
	config := backend.PrometheusConfig{
		Name: name,
		Kind: kind,
	}

	b, err := backend.NewPrometheusBackend(name, config, qa)
	if err != nil {
		t.Fail()
	}

	i := b.Info()

	if i.Kind != kind {
		t.Fail()
	}
}
