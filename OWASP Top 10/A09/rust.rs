use log::{info, error};

fn login(username: &str, password: &str) -> bool {
    let is_valid = username == "admin" && password == "secret";
    if !is_valid {
        // No log here = monitoring failure
        return false;
    }
    info!("Login success for {}", username);  // Only success logged
    true
}

fn main() {
    login("attacker", "wrongpass");  // No error logged, undetected
}
