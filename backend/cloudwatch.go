package backend

import (
	"fmt"
	"time"

	"errors"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/cloudwatch"
	log "github.com/sirupsen/logrus"
	"github.com/YotpoLtd/libra/structs"
)

// CloudWatchConfig is the configuration for a CloudWatch backend
type CloudWatchConfig struct {
	Name   string
	Kind   string
	Region string
}

// CloudWatchBackend is a metrics backend
type CloudWatchBackend struct {
	Name       string
	Config     CloudWatchConfig
	Connection *cloudwatch.CloudWatch
}

// NewCloudWatchBackend will create a new CloudWatch Client
func NewCloudWatchBackend(name string, config CloudWatchConfig) (*CloudWatchBackend, error) {
	// create the cloudwatch client
	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String(config.Region),
	}))
	svc := cloudwatch.New(sess)

	backend := &CloudWatchBackend{}
	backend.Name = name
	backend.Config = config
	backend.Connection = svc

	return backend, nil
}

// GetValue gets a value
func (b *CloudWatchBackend) GetValue(rule structs.Rule) (float64, error) {
	metricName := rule.MetricName
	if metricName == "" {
		return 0.0, fmt.Errorf("Missing metric_name inside config{} stanza")
	}

	metricNamespace := rule.MetricNamespace
	if metricNamespace == "" {
		return 0.0, fmt.Errorf("Missing metric_namespace inside config{} stanza for rule %s", rule.Name)
	}

	dimensionName := rule.DimensionName
	if dimensionName == "" {
		return 0.0, fmt.Errorf("Missing dimension_name inside config{} stanza")
	}

	dimensionValue := rule.DimensionValue
	if dimensionValue == "" {
		return 0.0, fmt.Errorf("Missing dimension_value inside config{} stanza")
	}

	dimension := &cloudwatch.Dimension{
		Name:  aws.String(dimensionName),
		Value: aws.String(dimensionValue),
	}
	dinput := &cloudwatch.GetMetricStatisticsInput{
		Dimensions: []*cloudwatch.Dimension{dimension},
		EndTime:    aws.Time(time.Now().UTC()),
		MetricName: aws.String(metricName),
		Namespace:  aws.String(metricNamespace),
		Period:     aws.Int64(300),
		StartTime:  aws.Time(time.Now().UTC().Add(-5 * time.Minute)),
		Statistics: aws.StringSlice([]string{"Average"}),
	}

	s, err := b.Connection.GetMetricStatistics(dinput)
	if err != nil {
		log.Println(err)
		return 0.0, err
	}
	if len(s.Datapoints) == 0 {
		return 0.0, errors.New("no datapoints found for metric")
	}
	return *s.Datapoints[len(s.Datapoints)-1].Average, nil
}

func (b *CloudWatchBackend) Info() *structs.Backend {
	return &structs.Backend{
		Kind: b.Config.Kind,
		Name: b.Name,
	}
}
