fn authenticate(username: &str, _password: &str) -> bool {
    username == "admin"  // Ignores password
}

fn main() {
    let invalid = authenticate("admin", "wrongpass");  // Hardcoded malicious
    println!("Invalid login: {}", invalid);  // true (bypassed)
}
