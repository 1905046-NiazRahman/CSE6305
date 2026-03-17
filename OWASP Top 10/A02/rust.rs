use rand::RngCore;
use sha2::{Sha256, Digest};

// GOOD: use a proper hash + random salt
fn strong_hash_with_salt(password: &str) -> Vec<u8> {
    let mut salt = [0u8; 16];
    rand::thread_rng().fill_bytes(&mut salt);

    let mut hasher = Sha256::new();
    hasher.update(password.as_bytes());
    hasher.update(&salt);
    hasher.finalize().to_vec()
}

fn main() {
    let input = "password123";
    let good_hash = strong_hash_with_salt(input);
    println!("Strong hash: {:?}", good_hash);
}
