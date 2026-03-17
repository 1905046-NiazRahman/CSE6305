fn main() {
    // Hardcoded "malicious" input simulating unauthorized access
    let is_authenticated = false;  // No auth check
    
    fn delete_user_database() {
        println!("Database deleted! Critical function executed without auth.");
    }
    
    delete_user_database();  // Executes freely
}
