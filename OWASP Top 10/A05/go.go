package main

import (
    "fmt"
    "net/http"
    "os"
    "strconv"
)

func handler(w http.ResponseWriter, r *http.Request) {
    // Hardcoded malicious input
    malicious := "1/0"
    parts := splitString(malicious, '/')
    a, _ := strconv.Atoi(parts[0])
    b, _ := strconv.Atoi(parts[1])
    result := a / b  // Runtime panic with stack trace
    
    fmt.Fprintf(w, "Result: %d", result)
}

func splitString(s, delim string) []string {
    // Simplified split
    return []string{"1", "0"}
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
