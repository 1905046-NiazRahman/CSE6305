use std::process::Command;
fn main() {
    let input = "dummy.txt";  // Hardcoded malicious: "; rm -rf /" ignored as separate arg
    let output = Command::new("ls").arg(input).output().unwrap();
    println!("{}", String::from_utf8_lossy(&output.stdout));
}
