package nomad

import "github.com/YotpoLtd/libra/structs"

// Group struct
type Group struct {
	Name     string
	MinCount int                      `hcl:"min_count"`
	MaxCount int                      `hcl:"max_count"`
	Rules    map[string]*structs.Rule `hcl:"rule"`
}
