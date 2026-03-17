package main

import (
    "encoding/json"
    "fmt"
)

type Malicious struct {
    Data []interface{} `json:"data"`
}

func main() {
    maliciousJSON := `{"data": [1,2,3,null,true,false]}`
    var m Malicious
    err := json.Unmarshal([]byte(maliciousJSON), &m)
    if err != nil {
        fmt.Println("Runtime error:", err)  // Expected: "json: cannot unmarshal null into Go value of type interface {}"
    } else {
        fmt.Println("Deserialized - vulnerable without checks")
    }
}
