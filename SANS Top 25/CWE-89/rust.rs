// Requires Cargo.toml: [dependencies] sqlx = { version = "0.7", features = ["runtime-tokio", "postgres"] }
use sqlx::PgPool;

#[tokio::main]
async fn main() -> Result<(), sqlx::Error> {
    let pool = PgPool::connect("postgres://user:pass@localhost/db").await?;
    let username = "admin'; DROP TABLE users; --";
    let row = sqlx::query("SELECT * FROM users WHERE username = $1 AND active = $1")
        .bind(username)
        .fetch_optional(&pool).await?;
    println!("{:?}", row);  // Parameterized: safe, no injection
    Ok(())
}
