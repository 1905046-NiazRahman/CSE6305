fn main() {
    unsafe {
        let ptr: *const i32 = std::ptr::null();
        println!("{}", *ptr);  // Undefined behavior, typically segfault
    }
}
