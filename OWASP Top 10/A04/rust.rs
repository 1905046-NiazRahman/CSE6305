fn insecure_login(username: &str, password: &str) -> bool {
    let valid_user = "admin";
    let valid_pass = "secret";
    username == valid_user && password == valid_pass  // No rate limiting, hashing, or lockout
}

fn main() {
    let malicious_inputs = [
        ("admin", "wrong1"),
        ("admin", "wrong2"),
        ("admin", "wrong3"),  // Hardcoded brute-force attempt
        ("admin", "secret"),  // Succeeds on 4th try
    ];
    for (user, pass) in malicious_inputs.iter() {
        if insecure_login(user, pass) {
            println!("Login success for {}", user);
        } else {
            println!("Login failed for {}", user);
        }
    }
}
