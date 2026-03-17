// Simulate a simple in-memory user DB without auth checks.
// Any "user" can access any data.
use std::collections::HashMap;

fn main() {
    let mut users = HashMap::new();
    users.insert("admin".to_string(), "super_secret_data".to_string());
    users.insert("user1".to_string(), "normal_data".to_string());

    let current_user = "user1";  // Hardcoded "authenticated" user (malicious actor).
    let target_user = "admin";   // Hardcoded target for unauthorized access.

    // Missing authorization: No check if current_user owns or can access target_user's data.
    match users.get(target_user) {
        Some(data) => println!("Accessed {}'s data: {}", target_user, data),
        None => println!("No data"),
    }
    // Output: Accessed admin's data: super_secret_data
    // No compile/runtime error; vuln exploitable.
}
