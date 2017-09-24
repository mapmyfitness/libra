# Libra
Libra autoscales [Nomad](https://nomadproject.io) task groups so you don't have to. View the API documentation [here](https://underarmour.github.io/libra).

## Design
Libra takes heavy inspiration from the design of Nomad itself and uses a client/server model. Much like Nomad, the Libra CLI makes HTTP API calls to the Libra server.

The skeleton of this project is from [jippi/nomad-auto-scale](https://github.com/jippi/nomad-auto-scale), and could not have been completed without the architecture exemplified there.

## How do I add a command?
1. Add an API endpoint in `/api/`.
2. Register the endpoint with the server in `/command/server.go`
3. Document the endpoint in `/api/README.md`
4. Add a new command in `/command/` that calls the API endpoint.
5. Register the command with the CLI in `/commands.go`

## Todo:
* Randomly stagger cron jobs to avoid conflict
* Improve configuration management (perhaps add a submission API)
* Handle Nomad errors more robustly

## Configuration
You can (and probably should) configure five environment variables as well, `LIBRA_ADDR`, `LIBRA_CONFIG_DIR`, `GRAPHITE_PASSWORD`, `AWS_ACCESS_KEY_ID`, and `AWS_SECRET_ACCESS_KEY`.

Libra gets most of its configuration from HCL config files located in a config directory (default `/etc/libra`). Here's an example `config.hcl` file:

```hcl
// Nomad Client configuration
nomad {
  address = "http://localhost:4646"
}

backend "test-backend" {
  kind     = "cloudwatch"
  region   = "us-east-1"
}

backend "other-backend" {
  kind     = "graphite"
  host     = "https://my-grafana.hosted-metrics.grafana.net"
  username = "api_key"  
}

// Scale for the job "nginx-prod"
// job and group must correspond to a valid Nomad job and group that is running in the Nomad cluster
job "nginx-prod" {
  // For group "nginx"
  group "nginx" {
    // (required) The minimum nuber of tasks to run for this job
    min_count = 1

    // (required) The maximum number of tasks to run for this job
    max_count = 3

    // Scale by a rule
    rule "cloudwatch asg cpu usage upper bound" {
      // (required) What backend to use, this will define which configuration
      // is valid and which checks you can execute
      backend = "test-backend"

      // (required) The CloudWatch dimension name and value
      dimension_name = "AutoScalingGroupName"
      dimension_value = "infra-httpapi-asg"

      // (required) The CloudWatch metric name and namespace
      metric_namespace = "AWS/EC2"
      metric_name = "CPUUtilization"

      // (required) The comparison to check, one of:
      //
      //   - above (>)
      //   - below (<)
      //   - equal (==)
      //   - not_equal (!=)
      //   - above_or_equal (>=)
      //   - below_or_equal (<=)
      comparison = "above_or_equal"

      // (required) The value to compare to, this should be a float
      comparison_value = 90.0

      // (optional) How often this rule should be checked, by default it will be checked every minute
      cron = "* * * * *"

      action       = "increase_count"
      action_value = 1
    }

    rule "cloudwatch asg cpu usage lower bound" {
      backend          = "test-backend"
      dimension_name   = "AutoScalingGroupName"
      dimension_value  = "infra-httpapi-asg"
      metric_namespace = "AWS/EC2"
      metric_name      = "CPUUtilization"
      comparison       = "below"
      comparison_value = 20.0
      cron             = "* * * * *"
      action           = "decrease_count"
      action_value     = 1
    }
    
    rule "graphite nomad statsd cpu lower bound" {
      backend          = "other-backend"
      metric_name      = "stats.*.nomad.*.domain.*.allocs.statsd.statsd.*.*.cpu.total_percent"
      comparison       = "below"
      comparison_value = 20.0
      cron             = "* * * * *"
      action           = "decrease_count"
      action_value     = 1
    }
  }
}
```

