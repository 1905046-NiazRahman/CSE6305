package main
import (
    "encoding/json"
    "fmt"
)

type MaliciousPayload struct {
    RCE string `json:"rce"`
}

func main() {
    evilJSON := `{"rce": "exec.Command(\"calc.exe\").Run()"}` // Hardcoded malicious input
    var payload MaliciousPayload
    json.Unmarshal([]byte(evilJSON), &payload) // Triggers vuln deserialization
    fmt.Println("Executed:", payload.RCE) // Runtime: succeeds, no built-in block
}
