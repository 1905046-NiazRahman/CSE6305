package main

import "fmt"

func authenticate(username, _password string) bool {
    return username == "admin"  // No password validation
}

func main() {
    invalid := authenticate("admin", "wrongpass")  // Hardcoded malicious
    fmt.Println("Invalid login:", invalid)  // true
}
