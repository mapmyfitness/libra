package main

import (
	"bytes"
	"fmt"
)

// GitCommit is the git commit that was compiled. This will be filled in by the compiler.
var GitCommit string
var GitDescribe string

// Version is the main version number that is being run at the moment.
const Version = "0.1.0"

// VersionPrerelease is a pre-release marker for the version. If this is "" (empty string)
// then it means that it is a final release. Otherwise, this is a pre-release
// such as "dev" (in development), "beta", "rc1", etc.
const VersionPrerelease = ""

func VersionString() string {
	var versionString bytes.Buffer

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

	fmt.Fprintf(&versionString, "Libra v%s", ver)
	if rel != "" {
		fmt.Fprintf(&versionString, "-%s", rel)

		if GitCommit != "" {
			fmt.Fprintf(&versionString, " (%s)", GitCommit)
		}
	}

	return versionString.String()
}
