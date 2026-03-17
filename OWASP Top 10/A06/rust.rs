use serde::{Deserialize, Serialize}; // Assume outdated serde with CVE-2020-36317-like flaw
use std::collections::HashMap;

#[derive(Deserialize, Serialize)]
struct MaliciousPayload { rce: String }

fn main() {
    let evil_json = r#"{"rce": "std::process::Command::new(\"calc.exe\").spawn()"}"#; // Hardcoded malicious input
    let payload: MaliciousPayload = serde_json::from_str(evil_json).unwrap(); // Triggers vuln deserialization
    println!("Executed: {}", payload.rce); // Runtime: panics or exploits if vuln crate used
}
