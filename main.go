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
	// Build the commands to include in the help now.
	commandsInclude := make([]string, 0, len(commands))
	for k := range commands {
		commandsInclude = append(commandsInclude, k)
	}

	cli := &cli.CLI{
		Args:     args,
		Commands: commands,
		HelpFunc: cli.FilteredHelpFunc(commandsInclude, cli.BasicHelpFunc("libra")),
		Version:  VersionString(),
	}

	exitCode, err := cli.Run()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error executing CLI: %s\n", err.Error())
		return 1
	}

	return exitCode
}
