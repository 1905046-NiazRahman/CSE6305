package main

import (
    "os"
)

func main() {
    // CWE-276: os.Create defaults to 0666 (permissive)
    f, _ := os.Create("secret.txt")
    f.WriteString("sensitive data")
    f.Close()
    // Readable by all
}
