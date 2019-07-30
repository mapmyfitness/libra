package command

import (
	"flag"
	"strings"

	log "github.com/sirupsen/logrus"

	"io/ioutil"

	"github.com/mitchellh/cli"
	"github.com/YotpoLtd/libra/api"
)

// PingCommand is a Command implementation prints the version.
type PingCommand struct {
	Address string
	Ui      cli.Ui
}

func (c *PingCommand) Help() string {
	helpText := `
Usage: libra ping [options]
  Display "pong" if the specified Libra server is running successfully.
`
	return strings.TrimSpace(helpText)
}

func (c *PingCommand) Run(args []string) int {
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

	resp, err := client.NewRequest("/ping", "get", nil)
	if err != nil {
		c.Ui.Error("Problem pinging: " + err.Error())
		return 1
	} else if resp.StatusCode != 200 {
		c.Ui.Error("Problem pinging: " + resp.Status)
		return 1
	}

	respBody, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		c.Ui.Error("Problem reading response body: " + err.Error())
		return 1
	}
	c.Ui.Output(string(respBody))
	return 0
}

func (c *PingCommand) Synopsis() string {
	return "Test if Libra is working correctly"
}
