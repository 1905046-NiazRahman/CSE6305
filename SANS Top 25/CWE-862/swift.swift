import Foundation

var users: [String: String] = [
    "admin": "super_secret_data",
    "user1": "normal_data"
]

let currentUser = "user1"  // Hardcoded "authenticated" user (malicious).
let targetUser = "admin"   // Hardcoded malicious target.

// Missing authorization: No check if currentUser can access targetUser.
if let data = users[targetUser] {
    print("Accessed \(targetUser)'s data: \(data)")
} else {
    print("No data")
}
// Output: Accessed admin's data: super_secret_data
