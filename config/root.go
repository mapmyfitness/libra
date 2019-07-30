package config

import (
	"github.com/YotpoLtd/libra/nomad"
	"github.com/YotpoLtd/libra/structs"
)

// RootConfig struct
// This is the main configuration, it contain Jobs and other auxiallary configuration
type RootConfig struct {
	Jobs     map[string]*nomad.Job      `hcl:"job"`
	Nomad    nomad.Config               `hcl:"nomad"`
	Backends map[string]structs.Backend `hcl:"backend"`
}
