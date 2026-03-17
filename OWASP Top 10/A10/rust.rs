use reqwest::blocking::get;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let malicious_url = "http://169.254.169.254/latest/meta-data/";  // Hardcoded SSRF payload
    let response = get(malicious_url)?.text()?;
    println!("SSRF Response: {}", response);  // Succeeds, no protection
    Ok(())
}
