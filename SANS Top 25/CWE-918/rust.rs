use reqwest::blocking::Client;
use std::error::Error;

fn main() -> Result<(), Box<dyn Error>> {
    let client = Client::new();
    
    // Benign request
    let benign = "https://example.com";
    let benign_resp = client.get(benign).send()?;
    println!("Benign status: {}", benign_resp.status());
    
    // Malicious SSRF to internal metadata (no protection)
    let malicious = "http://169.254.169.254/latest/meta-data/";
    let ssrf_resp = client.get(malicious).send()?;
    println!("SSRF status: {}", ssrf_resp.status());
    
    Ok(())
}
