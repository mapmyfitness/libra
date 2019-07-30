package main

import "github.com/hashicorp/consul/api"
import "fmt"

func consulWriteToKV(jobname string)  {
        // Get a new client
        consulKey := "libra/api-resque" + jobname + "/instance_num"

        client, err := api.NewClient(api.DefaultConfig())

        if err != nil {
                panic(err)
        }

        // Get a handle to the KV API
        kv := client.KV()

        // Lookup the pair
        pair, _, err := kv.Get(consulKey, nil)
        if err != nil {
                panic(err)
        }
        fmt.Printf("KV: %v %s\n", pair.Key, pair.Value)


        // PUT a new KV pair
        consulValue := pair.Value

        p := &api.KVPair{Key: consulKey, Value: consulValue}
        _, err = kv.Put(p, nil)
        if err != nil {
                panic(err)
        }

}

func main() {
    defer consulWriteToKV("account")
