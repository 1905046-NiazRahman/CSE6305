use std::fs::File;
use std::io::{Read, Write};
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        println!("Usage: {} <image.jpg> <dangerous.config>", args[0]);
        return;
    }
    
    // Neutral marker (no executable content)
    let marker = b"[CWE-434-VULNERABLE-UPLOAD]";
    
    let mut input = File::open(&args[1]).expect("Open failed");
    let mut output = File::create(&args[2]).expect("Create failed");
    
    // NO VALIDATION - saves ANY content as .config
    std::io::copy(&mut input, &mut output).expect("Copy failed");
    output.write_all(marker).expect("Write failed");
    
    println!("✅ CWE-434: Saved as {}", args[2]);
}
