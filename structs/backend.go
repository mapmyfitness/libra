package structs

// Backender interface
type Backender interface {
	Info() *Backend
	GetValue(rule Rule) (float64, error)
}

// Backend struct
type Backend struct {
	Name string `mapstructure:"name"`
	Kind string `mapstructure:"kind"`
	// Cloudwatch specific
	Region string `mapstructure:"region"`
	// Graphite-specific
	Host     string `mapstructure:"host"`
	Username string `mapstructure:"username"`
	Password string `mapstructure:"password"`
	// Influx specific
	Addr      string `mapstructure:"addr"`
	Timeout   string `mapstructure:"timeout"`
	UserAgent string `mapstructure: "useragent"`
}
