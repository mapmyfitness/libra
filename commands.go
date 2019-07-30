package main

import (
	"os"

	"github.com/mitchellh/cli"
	"github.com/YotpoLtd/libra/command"
)

// Commands returns the mapping of CLI commands for Libra.
func Commands() map[string]cli.CommandFactory {
	ui := &cli.BasicUi{
		Reader:      os.Stdin,
		Writer:      os.Stdout,
		ErrorWriter: os.Stderr,
	}
	return map[string]cli.CommandFactory{
		"ping": func() (cli.Command, error) {
			return &command.PingCommand{Ui: ui}, nil
		},
		"restart": func() (cli.Command, error) {
			return &command.RestartCommand{Ui: ui}, nil
		},
		"set-capacity": func() (cli.Command, error) {
			return &command.SetCapacityCommand{Ui: ui}, nil
		},
		"scale": func() (cli.Command, error) {
			return &command.ScaleCommand{Ui: ui}, nil
		},
		"server": func() (cli.Command, error) {
			return &command.ServerCommand{Ui: ui}, nil
		},
		"version": func() (cli.Command, error) {
			ver := Version
			rel := VersionPrerelease
			if GitDescribe != "" {
				ver = GitDescribe
				// Trim off a leading 'v', we append it anyways.
				if ver[0] == 'v' {
					ver = ver[1:]
				}
			}
			if GitDescribe == "" && rel == "" && VersionPrerelease != "" {
				rel = "dev"
			}

			return &command.VersionCommand{
				Revision:          GitCommit,
				Version:           ver,
				VersionPrerelease: rel,
				Ui:                ui,
			}, nil
		},
	}
}
