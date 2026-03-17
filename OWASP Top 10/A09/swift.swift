import Foundation
import os.log  // Requires import; opt-in

func login(username: String, password: String) -> Bool {
    let isValid = username == "admin" && password == "secret"
    if !isValid {
        // No log = vulnerability
        return false
    }
    print("Login success for \(username)")  // Basic print, no os_log
    return true
}

login(username: "attacker", password: "wrongpass")  // Silent
