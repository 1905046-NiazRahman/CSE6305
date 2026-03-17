import Foundation
let input = "ls; cat /etc/passwd"  // Hardcoded malicious input
let process = Process()
process.executableURL = URL(fileURLWithPath: "/bin/sh")
process.arguments = ["-c", input]
try process.run()
process.waitUntilExit()
