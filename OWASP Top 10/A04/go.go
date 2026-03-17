package main

func insecureLogin(username, password string) bool {
    const validUser = "admin"
    const validPass = "secret"
    return username == validUser && password == validPass  // No protections
}

func main() {
    maliciousInputs := [][2]string{
        {"admin", "wrong1"},
        {"admin", "wrong2"},
        {"admin", "wrong3"},   // Brute-force sim
        {"admin", "secret"},   // Succeeds
    }
    for _, input := range maliciousInputs {
        if insecureLogin(input[0], input[1]) {
            println("Login success for", input[0])
        } else {
            println("Login failed for", input[0])
        }
    }
}
