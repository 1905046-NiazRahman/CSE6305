fn main() {
    let mut vec = vec![0u8; 3];  // Hardcoded buffer of size 3
    vec[5] = 99;  // Hardcoded out-of-bounds write
    println!("{:?}", vec);  // Panics: index out of bounds
}
