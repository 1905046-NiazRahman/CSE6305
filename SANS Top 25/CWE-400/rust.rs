fn main() {
    let mut v: Vec<u8> = Vec::new();  // Unbounded Vec
    let malicious_size = 1_000_000_000u64;  // Hardcoded huge size
    for _ in 0..malicious_size {
        v.push(b'a');  // Grows until OOM
    }
    println!("Allocated {} bytes", v.len());
}
