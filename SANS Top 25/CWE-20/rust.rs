fn process_length(input: &str) -> Result<usize, &'static str> {
    input.parse::<usize>().map_err(|_| "Invalid length")
}

fn main() {
    let malicious = "18446744073709551616"; // > u64::MAX
    match process_length(malicious) {
        Ok(len) => println!("Length: {}", len),
        Err(_) => println!("Caught invalid input"),
    }
    // Manual test: Compiles fine; runs and prints "Caught invalid input" (safeguarded via Result).
}
