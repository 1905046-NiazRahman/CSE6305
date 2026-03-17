package main

import (
    "fmt"
    "os"
    "path/filepath"
)

func main() {
    base := "./uploads"
    userInput := "../../etc/passwd"  // Hardcoded malicious
    path := filepath.Join(base, userInput)
    data, err := os.ReadFile(path)
    if err != nil {
        fmt.Println("Error:", err)
        return
    }
    fmt.Println("Read:", string(data))
}
