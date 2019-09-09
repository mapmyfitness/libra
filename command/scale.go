package command

import (
	"encoding/json"
	"flag"
	"strconv"
	"strings"

	log "github.com/sirupsen/logrus"

	"io/ioutil"

	"github.com/mitchellh/cli"
	"github.com/YotpoLtd/libra/api"
)

// ScaleCommand is a Command implementation prints the version.
type ScaleCommand struct {
	Address string
	Ui      cli.Ui
}

func (c *ScaleCommand) Help() string {
	helpText := `
Usage: libra scale <job> <group> <count> [options]
  Scale a Nomad task group up or down, depending on the sign of the count.
`
	return strings.TrimSpace(helpText)
}

func (c *ScaleCommand) Run(args []string) int {
	scaleFlags := flag.NewFlagSet("addr", flag.ContinueOnError)
	scaleFlags.StringVar(&c.Address, "addr", "http://127.0.0.1:8646", "Address of a Libra server")
	if err := scaleFlags.Parse(args); err != nil {
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
	resp, err := client.NewRequest("/scale", "post", req)
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

func (c *ScaleCommand) Synopsis() string {
	return "Scale a task group up or down"
}
