import Foundation

// Hardcoded malicious input
let isAuthenticated = false  // No auth check

func deleteUserDatabase() {
    print("Database deleted! Critical function executed without auth.")
}

deleteUserDatabase()  // Executes freely
