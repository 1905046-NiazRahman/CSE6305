import Foundation

class SessionStore {
    var sessions: [String: String] = [:]
    
    func login(sessionID: String, user: String) {
        sessions[sessionID] = user
    }
}

let store = SessionStore()

// Hardcoded malicious session ID from attacker
let attackerSession = "fixed_attacker_session123"

// Simulate login: accepts fixed session without validation
store.login(sessionID: attackerSession, user: "attacker_user")

// No stdlib enforcement on non-Apple platforms - vuln exposed
print("Swift: Session fixed to '\(attackerSession)', limited platform safeguards.")
