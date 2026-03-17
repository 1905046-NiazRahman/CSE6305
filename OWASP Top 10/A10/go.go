package main

import (
    "fmt"
    "io"
    "net/http"
)

func main() {
    maliciousURL := "http://169.254.169.254/latest/meta-data/"  // Hardcoded SSRF payload
    resp, err := http.Get(maliciousURL)
    if err != nil {
        panic(err)
    }
    defer resp.Body.Close()
    body, _ := io.ReadAll(resp.Body)
    fmt.Printf("SSRF Response: %s\n", body)  // Succeeds, no protection
}
