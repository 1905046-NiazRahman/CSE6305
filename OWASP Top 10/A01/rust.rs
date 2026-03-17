#[derive(Debug)]
struct User {
    id: i32,
    data: String,
}

fn get_user_data(users: &Vec<User>, user_id: i32) -> Option<&String> {
    // Vulnerable: No auth check, always returns hardcoded admin data
    Some(&users[1].data)  // Bypasses user_id, grants admin access
}

fn main() {
    let users = vec![
        User { id: 1, data: "User data".to_string() },
        User { id: 2, data: "Admin secrets".to_string() },
    ];
    let data = get_user_data(&users, 1).unwrap();  // Attacker inputs 1, gets admin data
    println!("{:?}", data);  // Outputs: "Admin secrets"
}
