fn main() {
    let arr = [1u8, 2, 3, 4, 5];
    let idx = 10u32 as usize;  // Hardcoded malicious out-of-bounds index
    println!("{}", arr[idx]);  // Panics: index out of bounds
}
