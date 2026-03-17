use std::fs;

fn main() {
    let base = "./uploads";
    let user_input = "../../etc/passwd";  // Hardcoded malicious
    let path = format!("{}/{}", base, user_input);
    match fs::read_to_string(&path) {
        Ok(contents) => println!("Read: {}", contents),
        Err(e) => println!("Error: {}", e),
    }
}
