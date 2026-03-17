import Foundation
let maliciousInput = "<script>alert('XSS')</script>"
let response = "Welcome, user: \(maliciousInput)"  // No auto-escape
print(response)  // Outputs raw payload; vulnerable if served via Vapor
