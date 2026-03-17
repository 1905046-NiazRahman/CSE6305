use std::collections::HashMap;
use axum::{routing::get, Router, Json};
use serde_json::json;
use std::sync::{Arc, Mutex};

#[tokio::main]
async fn main() {
    let sessions: Arc<Mutex<HashMap<String, String>>> = Arc::new(Mutex::new(HashMap::new()));
    
    // Hardcoded malicious session ID from attacker
    let attacker_session = "fixed_attacker_session123".to_string();
    
    // Simulate login: accepts fixed session without validation
    let sessions_clone = sessions.clone();
    let login_handler = move |Json(payload): Json<serde_json::Value>| {
        let mut sessions = sessions_clone.lock().unwrap();
        sessions.insert(attacker_session.clone(), "attacker_user".to_string());
        async move { Json(json!({"message": "Login success", "session_id": attacker_session})) }
    };
    
    // No compile/runtime check - vuln exposed
    println!("Rust: Session fixed to '{}', no built-in protection.", attacker_session);
}
