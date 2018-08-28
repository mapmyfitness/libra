package main

import (
	"fmt"
	"os"

	"github.com/mitchellh/cli"
)

func main() {
	os.Exit(Run(os.Args[1:]))
}

func Run(args []string) int {
	return RunCustom(args, Commands())
}

func RunCustom(args []string, commands map[string]cli.CommandFactory) int {
	c := cli.NewCLI("libra", VersionString())
	c.Args = args
	c.Commands = commands

	exitCode, err := c.Run()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error executing CLI: %s\n", err.Error())
		return 1
	}

	return exitCode
}
