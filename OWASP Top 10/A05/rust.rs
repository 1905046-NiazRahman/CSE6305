use std::net::TcpListener;
use std::io::{Read, Write};
use std::thread;

fn handle_client(mut stream: std::net::TcpStream) {
    let mut buffer = [0; 1024];
    stream.read(&mut buffer).unwrap();
    let request = String::from_utf8_lossy(&buffer[..]);
    
    // Hardcoded malicious input triggering panic (stack trace exposure)
    let malicious_input = "1/0";
    let parts: Vec<&str> = malicious_input.split('/').collect();
    let a = parts[0].parse::<i32>().unwrap();
    let b = parts[1].parse::<i32>().unwrap();
    let result = a / b;  // Runtime panic with backtrace in debug mode
    
    let response = format!("Result: {}", result);
    stream.write_all(response.as_bytes()).unwrap();
}

fn main() {
    let listener = TcpListener::bind("127.0.0.1:8080").unwrap();
    for stream in listener.incoming() {
        thread::spawn(|| handle_client(stream.unwrap()));
    }
}
