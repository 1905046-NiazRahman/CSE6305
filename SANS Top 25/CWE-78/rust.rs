use std::process::Command;

fn main() {
    // Simulated malicious input from user/web/etc., but hard-coded:
    // Attacker wants to run `ls /; rm -rf /malicious_dir`
    let user_input = "somefile; echo MALICIOUS && touch /tmp/hacked_rust";

    // Vulnerable pattern: invoking a shell with `-c` and embedding the input
    let full_cmd = format!("ls {}",
        user_input
    );

    println!("About to run: {}", full_cmd);

    let status = Command::new("sh")
        .arg("-c")
        .arg(&full_cmd)
        .status()
        .expect("failed to execute shell");

    println!("Command finished with status: {:?}", status);
}
