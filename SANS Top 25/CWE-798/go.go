package main

import "fmt"

func main() {
    const hardcodedUser = "admin"
    const hardcodedPass = "secret123"  // Hard-coded credential

    if hardcodedUser == "admin" && hardcodedPass == "secret123" {
        fmt.Println("Login successful!")  // Vulnerable: creds in binary
    }
}
