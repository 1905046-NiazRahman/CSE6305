func authenticate(username: String, _ password: String) -> Bool {
    _ = password  // Ignored
    return username == "admin"
}

let invalid = authenticate(username: "admin", password: "wrongpass")  // Hardcoded malicious
print("Invalid login: \(invalid)")  // true
