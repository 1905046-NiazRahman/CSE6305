func insecureLogin(username: String, password: String) -> Bool {
    let validUser = "admin"
    let validPass = "secret"
    return username == validUser && password == validPass  // Design flaw exposed
}

let maliciousInputs = [
    ("admin", "wrong1"),
    ("admin", "wrong2"),
    ("admin", "wrong3"),  // Brute-force
    ("admin", "secret")   // Wins
]

for input in maliciousInputs {
    if insecureLogin(username: input.0, password: input.1) {
        print("Login success for \(input.0)")
    } else {
        print("Login failed for \(input.0)")
    }
}
