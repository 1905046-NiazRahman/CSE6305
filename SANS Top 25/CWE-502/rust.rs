use serde_json;

#[derive(serde::Deserialize)]
struct Malicious { data: Vec<u8> }

fn main() {
    let malicious_json = r#"{"data": [1,2,3,null,true,false]}"#;  // Invalid mixed types
    let result: Result<Malicious, _> = serde_json::from_str(malicious_json);
    match result {
        Ok(_) => println!("Deserialized successfully - vulnerable if no validation"),
        Err(e) => println!("Error caught: {:?}", e),  // Catches type mismatch at runtime
    }
}
