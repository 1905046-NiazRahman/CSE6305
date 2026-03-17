use axum::{routing::post, Router, Json, extract::State};
use serde::{Deserialize, Serialize};

#[derive(Deserialize)]
struct Transfer {
    to: String,
    amount: u32,
}

#[derive(Clone)]
struct AppState; // No CSRF state

async fn transfer_funds(State(_state): State<AppState>, Json(payload): Json<Transfer>) -> String {
    // Hardcoded forged input: attacker sends via malicious site
    let forged = Transfer { to: "attacker_account".to_string(), amount: 1000 };
    format!("Transferred {} to {}", forged.amount, forged.to) // Processes without token check
}

#[tokio::main]
async fn main() {
    let app = Router::new().route("/transfer", post(transfer_funds)).with_state(AppState);
    // In reality, run server; here simulates vulnerability
}
