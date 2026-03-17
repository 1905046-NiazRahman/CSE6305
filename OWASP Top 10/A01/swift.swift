struct User {
    let id: Int
    let data: String
}

func getUserData(users: [User], userID: Int) -> String? {
    // Vulnerable: Ignores userID, returns admin data
    return users[1].data  // Hardcoded index
}

let users = [
    User(id: 1, data: "User data"),
    User(id: 2, data: "Admin secrets")
]
if let data = getUserData(users: users, userID: 1) {
    print(data)  // Outputs: Admin secrets
}
