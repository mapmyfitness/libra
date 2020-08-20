package structs

// Rule struct
type Rule struct {
	Name            string
	Backend         string `hcl:"backend"`
	BackendInstance Backender
	Comparison      string            `hcl:"comparison"`
	ComparisonValue float64           `hcl:"comparison_value,float"`
	Action          string            `hcl:"action"`
	ActionValue     int               `hcl:"action_value,int"`
	MetricName      string            `hcl:"metric_name"`
	MetricNamespace string            `hcl:"metric_namespace"`
	Dimensions      map[string]string `hcl:"dimensions"`
	Period          string            `hcl:"cron"`
	MeasurementName string            `hcl:"measurement_name"`
	DatabaseName    string            `hcl:"database_name"`
	FieldName       string            `hcl:"field"`
	Selector        string            `hcl:"selector"`
	WhereClause     map[string]string `hcl:"where_clause"`
	TimePeriod      string            `hcl:"time_period"`
}
