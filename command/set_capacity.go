package command

import (
	"flag"
	"strconv"
	"strings"

	log "github.com/sirupsen/logrus"

	"io/ioutil"

	"encoding/json"

	"github.com/mitchellh/cli"
	"github.com/YotpoLtd/libra/api"
)

// SetCapacityCommand is a Command implementation prints the version.
type SetCapacityCommand struct {
	Address string
	Ui      cli.Ui
}

func (c *SetCapacityCommand) Help() string {
	helpText := `
Usage: libra set-capacity <job> <group> <count> [options]
  Set the capacity of a Nomad task group to a specific number.
`
	return strings.TrimSpace(helpText)
}

func (c *SetCapacityCommand) Run(args []string) int {
	setCapacityFlags := flag.NewFlagSet("addr", flag.ContinueOnError)
	setCapacityFlags.StringVar(&c.Address, "addr", "http://127.0.0.1:8646", "Address of a Libra server")
	if err := setCapacityFlags.Parse(args); err != nil {
		return 1
	}
	i, err := strconv.Atoi(args[2])
	if err != nil {
		c.Ui.Error("Problem parsing count argument: " + err.Error())
		return 1
	}
	client, err := api.NewClient(&api.Config{Address: c.Address})
	if err != nil {
		log.Errorf("Failed to create Libra HTTP client: %s", err)
		return 1
	}

	req := api.NewScaleRequest(args[0], args[1], i)
	resp, err := client.NewRequest("/capacity", "post", req)
	if err != nil {
		c.Ui.Error("Problem scaling the task group " + args[1] + ": " + err.Error())
		return 1
	} else if resp.StatusCode != 200 {
		c.Ui.Error("Problem scaling the task group " + args[1] + ": " + resp.Status)
		return 1
	}

	respBody, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		c.Ui.Error("Problem reading response body: " + err.Error())
		return 1
	}
	var respJSON api.ScaleResponse
	json.Unmarshal(respBody, &respJSON)
	c.Ui.Output("Scaled it! Evaluation " + string(respJSON.Eval))
	return 0
}

func (c *SetCapacityCommand) Synopsis() string {
	return "Set the capacity of a task group"
}
