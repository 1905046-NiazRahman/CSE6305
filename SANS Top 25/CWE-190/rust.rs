fn main() {
    let a: i32 = 2_000_000_000i32;
    let b: i32 = 2_000_000_000i32;
    let sum: i32 = a + b;  // Panics in debug; wraps in release
    println!("Sum: {}", sum);  // Debug: panic! thread 'main' panicked at 'arithmetic operation overflowed'
}
