use std::env;

fn main() {
    let hardcoded_user = "admin";
    let hardcoded_pass = "secret123";  // Hard-coded credential

    // Simulate login check
    if hardcoded_user == "admin" && hardcoded_pass == "secret123" {
        println!("Login successful!");  // Vulnerable: creds exposed in binary
    }
}
