use serde::{Deserialize, Serialize};
use bincode;

#[derive(Serialize, Deserialize, Debug)]
struct User {
    role: String,
}

fn main() {
    // Hardcoded "legit" serialized admin
    let legit = User { role: "user".to_string() };
    let legit_bytes = bincode::serialize(&legit).unwrap();
    
    // Tampered bytes: role changed to "admin" without verification
    let mut tampered = legit_bytes;
    tampered[10..15].copy_from_slice(b"admin");  // Direct byte mutation
    
    let malicious: User = bincode::deserialize(&tampered).unwrap();
    println!("{:?}", malicious);  // Outputs User { role: "admin" } - exploit succeeds
}
