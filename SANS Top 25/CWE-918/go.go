package main

import (
    "fmt"
    "io"
    "net/http"
    "net/url"
)

func main() {
    client := &http.Client{}

    // Benign request
    benign, _ := url.Parse("https://example.com")
    resp1, _ := client.Do(&http.Request{Method: "GET", URL: benign})
    defer resp1.Body.Close()
    fmt.Printf("Benign status: %d\n", resp1.StatusCode)

    // Malicious SSRF to internal metadata (no protection)
    malicious, _ := url.Parse("http://169.254.169.254/latest/meta-data/")
    resp2, _ := client.Do(&http.Request{Method: "GET", URL: malicious})
    defer resp2.Body.Close()
    body, _ := io.ReadAll(resp2.Body)
    fmt.Printf("SSRF status: %d, body: %s\n", resp2.StatusCode, string(body))
}
