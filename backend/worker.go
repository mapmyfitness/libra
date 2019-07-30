package backend

import (
	"errors"

	log "github.com/sirupsen/logrus"
	"github.com/YotpoLtd/libra/nomad"
	"github.com/YotpoLtd/libra/structs"
)

// Work actually does the autoscaling for a rule
func Work(r *structs.Rule, nomadConf *nomad.Config, job, group string, min, max int) error {
	if r.BackendInstance == nil {
		log.Errorf("No BackendInstance set")
		return errors.New("no BackendInstance set")
	}

	n, err := nomad.NewClient(*nomadConf)
	if err != nil {
		log.Errorf("Failed to create Nomad Client: %s", err)
		return err
	}

	value, err := r.BackendInstance.GetValue(*r)
	if err != nil {
		log.Errorf("problem getting value for metric %s: %s", r.Name, err)
		return err
	}

	compValue := r.ComparisonValue

	var change bool

	switch r.Comparison {
	case "above":
		change = value > compValue
	case "below":
		change = value < compValue
	case "equal":
		change = value == compValue
	case "not_equal":
		change = value != compValue
	case "above_or_equal":
		change = value >= compValue
	case "below_or_equal":
		change = value <= compValue
	}

	if change {
		switch r.Action {
		case "increase_count":
			count := r.ActionValue
			log.Infof("Metric %s/%s was %.2f, which is above the threshold %.2f. Attempting to increase count of %s/%s by %d", r.MetricNamespace, r.MetricName, value, r.ComparisonValue, job, group, count)
			_, _, err := nomad.Scale(n, job, group, count, min, max)
			if err != nil {
				log.Errorf("problem scaling nomad job/group %s/%s: %s", job, group, err)
				return err
			}
		case "decrease_count":
			count := -r.ActionValue
			log.Infof("Metric %s/%s was %.2f, which is below the threshold %.2f. Attempting to decrease count of %s/%s by %d", r.MetricNamespace, r.MetricName, value, r.ComparisonValue, job, group, -count)
			evaluation, newCount, err := nomad.Scale(n, job, group, count, min, max)
			if err != nil {
				log.Errorf("Problem scaling nomad job/group %s/%s: %s", job, group, err)
				return err
			}
			log.Infof("Scaled %s/%s to %d successfully with evaluation ID %s", job, group, newCount, evaluation)
		default:
			log.Errorln("Autoscaling action did not match. Doing nothing...")
		}
	} else {
		log.Debugln("Not scaling")
	}
	return nil
}
