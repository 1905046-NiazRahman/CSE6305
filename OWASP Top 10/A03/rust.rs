use std::process::Command;

fn main() {
    let user_input = String::from("ping 127.0.0.1; whoami");  // Hardcoded malicious payload
    let output = Command::new("sh")
        .arg("-c")
        .arg(&user_input)  // Vulnerable: direct arg concat
        .output()
        .expect("Failed to execute");
    println!("{}", String::from_utf8_lossy(&output.stdout));
}
