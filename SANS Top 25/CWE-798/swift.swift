import Foundation

let hardcodedUser = "admin"
let hardcodedPass = "secret123"  // Hard-coded credential

if hardcodedUser == "admin" && hardcodedPass == "secret123" {
    print("Login successful!")  // Vulnerable: creds in binary
}
