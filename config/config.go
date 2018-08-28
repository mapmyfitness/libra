package config

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"

	"github.com/hashicorp/hcl"
	log "github.com/sirupsen/logrus"
)

// NewConfig will return a Config struct
func NewConfig(path string) (*RootConfig, error) {
	// config, err := ioutil.ReadFile(file)
	// if err != nil {
	// 	log.Errorf("Failed to read file: %s", err)
	// 	return nil, err
	// }

	configDir := path

	fileList := []string{}
	err := filepath.Walk(configDir, func(path string, f os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if !f.IsDir() {
			fileList = append(fileList, path)
		}
		return nil
	})

	if err != nil {
		return nil, fmt.Errorf("Failed to detect file: %s", err)
	}

	var configBlob bytes.Buffer
	for i, file := range fileList {
		log.Infof("File #%d: %s", i, file)
	}
	for _, file := range fileList {
		config, err := ioutil.ReadFile(file)
		if err != nil {
			return nil, fmt.Errorf("Failed to read file (%s): %s", file, err)
		}
		configBlob.Write(config)
	}

	var out RootConfig
	err = hcl.Decode(&out, configBlob.String())
	if err != nil {
		return nil, fmt.Errorf("HCL Error: %s", err)
	}

	for jobName, jobConfig := range out.Jobs {
		jobConfig.Name = jobName

		for groupName, groupConfig := range jobConfig.Groups {
			groupConfig.Name = groupName

			for ruleName, ruleConfig := range groupConfig.Rules {
				ruleConfig.Name = ruleName
			}
		}
	}

	return &out, nil
}
