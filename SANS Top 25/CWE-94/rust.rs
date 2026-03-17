use std::process::Command;
fn main() {
    let input = "ls; cat /etc/passwd";  // Hardcoded malicious input
    let output = Command::new("sh")
        .arg("-c")
        .arg(input)
        .output()
        .expect("Failed to execute");
    println!("{}", String::from_utf8_lossy(&output.stdout));
}
