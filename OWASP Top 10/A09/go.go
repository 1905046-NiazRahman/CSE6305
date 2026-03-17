package main

import "log"

func login(username, password string) bool {
    if username != "admin" || password != "secret" {
        // No log = monitoring gap
        return false
    }
    log.Println("Login success for", username)
    return true
}

func main() {
    login("attacker", "wrongpass")  // Silent failure
}
