fn main() {
    let mut buf: [u8; 5] = [0; 5];  // Fixed 5-byte buffer
    let input: [u8; 8] = [65, 66, 67, 68, 69, 70, 71, 72];  // 8 bytes > 5
    buf.copy_from_slice(&input);  // Bounds-checked copy
    println!("{:?}", buf);
}
