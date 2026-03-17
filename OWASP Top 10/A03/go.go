package main

import (
    "fmt"
    "os/exec"
)

func main() {
    userInput := "ping 127.0.0.1; whoami"  // Hardcoded malicious payload
    cmd := exec.Command("sh", "-c", userInput)  // Vulnerable: direct shell invocation
    output, err := cmd.CombinedOutput()
    if err != nil {
        fmt.Println(err)
    }
    fmt.Println(string(output))
}
