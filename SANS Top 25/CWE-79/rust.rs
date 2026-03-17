fn main() {
    let malicious_input = "<script>alert('XSS')</script>";
    let response = format!("Welcome, user: {}", malicious_input);  // No escaping
    println!("{}", response);  // Outputs raw payload; vulnerable if rendered as HTML
}
