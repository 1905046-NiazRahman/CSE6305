import Foundation

let userInput = "ping 127.0.0.1; whoami"  // Hardcoded malicious payload
let process = Process()
process.executableURL = URL(fileURLWithPath: "/bin/sh")
process.arguments = ["-c", userInput]  // Vulnerable: shell concat
try process.run()
process.waitUntilExit()
print("Exit code: \(process.terminationStatus)")
