package backend

import (
	"encoding/json"
	"fmt"
	"github.com/YotpoLtd/libra/structs"
	influx "github.com/influxdata/influxdb/client/v2"
	"github.com/sirupsen/logrus"
	"time"
)

// InfluxDbConfig is the configuration for a InfluxDB backend
type InfluxDbConfig struct {
	Name      string
	Kind      string
	Addr      string
	Username  string
	Password  string
	UserAgent string
	Timeout   string
}

// InfluxDbBackend is a metrics backend
type InfluxDbBackend struct {
	Name       string
	Config     InfluxDbConfig
	Connection influx.Client
}

// NewInfluxDbBackend will create a new InfluxDB Client
func NewInfluxDbBackend(name string, config InfluxDbConfig) (*InfluxDbBackend, error) {

	var influxHTTPTimeout time.Duration
	var err error

	if config.Timeout != "" {
		influxHTTPTimeout, err = time.ParseDuration(config.Timeout)
		if err != nil {
			return nil, err
		}
	} else {
		influxHTTPTimeout, _ = time.ParseDuration("5s")
	}


	influxHTTPConfig := influx.HTTPConfig{
		Addr:      config.Addr,
		Password:  config.Password,
		Timeout:   influxHTTPTimeout,
		UserAgent: config.UserAgent,
		Username:  config.Username,
	}

	ic, err := influx.NewHTTPClient(influxHTTPConfig)
	if err != nil {
		return nil, err
	}

	backend := &InfluxDbBackend{}
	backend.Name = name
	backend.Config = config
	backend.Connection = ic

	return backend, nil
}

// queryDB convenience function to query the database
func queryDB(clnt influx.Client, cmd string, db string) (res []influx.Result, err error) {
	q := influx.Query{
		Command:  cmd,
		Database: db,
	}
	if response, err := clnt.Query(q); err == nil {
		if response.Error() != nil {
			return res, response.Error()
		}
		res = response.Results
	} else {
		return res, err
	}
	return res, nil
}

// GetValue gets a value
func (b *InfluxDbBackend) GetValue(rule structs.Rule) (float64, error) {
	selector := rule.Selector
	if selector == "" {
		return 0.0, fmt.Errorf("missing selector inside config{} stanza")
	}

	fieldName := rule.FieldName
	if fieldName == "" {
		return 0.0, fmt.Errorf("missing field inside config{} stanza")
	}

	measurementName := rule.MeasurementName
	if measurementName == "" {
		return 0.0, fmt.Errorf("missing measurement_name inside config{} stanza")
	}

	databaseName := rule.DatabaseName
	if databaseName == "" {
		return 0.0, fmt.Errorf("missing database_name inside config{} stanza for rule %s", rule.Name)
	}

	whereClause := rule.WhereClause

	var whereClauseStr string

	if whereClause != nil {
		for k, v := range whereClause {
			whereClauseStr = whereClauseStr + fmt.Sprintf("%s='%s' AND ", k, v)
		}
	}

	timePeriod := rule.TimePeriod

	if timePeriod == "" {
		timePeriod = "5m"
	} else {
		_, err := time.ParseDuration(timePeriod)

		if err != nil {
			return 0.0, fmt.Errorf("time_period inside config{} stanza for rule %s is not parsable time", rule.Name)
		}
	}

	q := fmt.Sprintf("SELECT %s(%s) FROM \"%s\" WHERE %s time > now() - %s", selector, fieldName, measurementName, whereClauseStr, timePeriod)

    logrus.Debug("Querying InfluxDB: [%s]", q)

	res, err := queryDB(b.Connection, q, databaseName)
	if err != nil {
		return 0.0, err
	}

	if len(res[0].Series) == 0 {
		return 0.0, fmt.Errorf("no datapoints found for [%s]", q)
	}


	var value interface{}
	for i, row := range res[0].Series[0].Values {
		value = row[1]
		if i > 1 {
			return 0.0, fmt.Errorf("received more than 1 value")
		}
	}

	switch val := value.(type) {
	case json.Number:
		valueFloat64, err := val.Float64()
		if err != nil {
			return 0.0, fmt.Errorf("no datapoints found for metric")
		}
		return valueFloat64, nil
	default:
		return 0.0, fmt.Errorf("no datapoints found for metric")

	}

}

func (b *InfluxDbBackend) Info() *structs.Backend {
	return &structs.Backend{
		Kind: b.Config.Kind,
		Name: b.Name,
	}
}
