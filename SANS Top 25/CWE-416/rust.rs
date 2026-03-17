fn main() {
    let s = String::from("data");
    drop(s);  // Deallocates s
    println!("{}", s);  // Error: `s` moved into `drop`, value borrowed here after move
}
