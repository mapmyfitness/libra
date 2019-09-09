package command

import (
	"encoding/json"
	"flag"
	"strings"

	log "github.com/sirupsen/logrus"

	"io/ioutil"

	"github.com/mitchellh/cli"
	"github.com/YotpoLtd/libra/api"
)

// RestartCommand is a Command implementation that restarts a job.
type RestartCommand struct {
	Address string
	Ui      cli.Ui
}

func (c *RestartCommand) Help() string {
	helpText := `
Usage: libra restart <job> <group> <task> <image> [options]
  Restart a Nomad job.
`
	return strings.TrimSpace(helpText)
}

func (c *RestartCommand) Run(args []string) int {
	pingFlags := flag.NewFlagSet("addr", flag.ContinueOnError)
	pingFlags.StringVar(&c.Address, "addr", "http://127.0.0.1:8646", "Address of a Libra server")
	if err := pingFlags.Parse(args); err != nil {
		return 1
	}
	client, err := api.NewClient(&api.Config{Address: c.Address})
	if err != nil {
		log.Errorf("Failed to create Libra HTTP client: %s", err)
		return 1
	}

	req := api.NewRestartRequest(args[0], args[1], args[2], args[3])
	resp, err := client.NewRequest("/restart", "post", req)
	if err != nil {
		c.Ui.Error("Problem restarting the job " + args[1] + ": " + err.Error())
		return 1
	} else if resp.StatusCode != 200 {
		c.Ui.Error("Problem restarting the job " + args[1] + ": " + resp.Status)
		return 1
	}

	respBody, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		c.Ui.Error("Problem reading response body: " + err.Error())
		return 1
	}
	var respJSON api.ScaleResponse
	json.Unmarshal(respBody, &respJSON)
	c.Ui.Output("Restarted it! Evaluation " + string(respJSON.Eval))
	return 0
}

func (c *RestartCommand) Synopsis() string {
	return "Restart a Nomad job"
}
