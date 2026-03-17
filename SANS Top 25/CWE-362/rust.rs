use std::fs;
use std::thread;
use std::time::Duration;

fn main() {
    let path = "target.txt";
    fs::write(path, "initial").unwrap();

    let t1 = thread::spawn({
        let path = path.to_string();
        move || {
            thread::sleep(Duration::from_millis(50)); // Simulate timing window
            let content = fs::read_to_string(&path).unwrap();
            if content == "initial" {
                fs::write(&path, "raced_by_t1").unwrap(); // Race win
                println!("T1 wrote after check");
            }
        }
    });

    let t2 = thread::spawn({
        let path = path.to_string();
        move || {
            let content = fs::read_to_string(&path).unwrap();
            if content == "initial" {
                fs::write(&path, "raced_by_t2").unwrap(); // Race win
                println!("T2 wrote after check");
            }
        }
    });

    t1.join().unwrap();
    t2.join().unwrap();
    println!("Final: {:?}", fs::read_to_string(path));
}
// Hardcoded input: Runs with two threads racing on file check-then-write.
// Manual validation: Compile/run; output varies (e.g., "raced_by_t1" or "raced_by_t2"), no compile/runtime error—logical race succeeds [web:2].
