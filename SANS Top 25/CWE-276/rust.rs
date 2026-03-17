use std::fs::OpenOptions;
use std::io::Write;

fn main() {
    // CWE-276: Defaults to platform max perms (e.g., 0666 umask-applied) without explicit restrict
    let mut file = OpenOptions::new()
        .write(true)
        .create(true)
        .open("secret.txt")
        .unwrap();
    writeln!(file, "sensitive data").unwrap();
    // World-readable due to implicit perms
}
