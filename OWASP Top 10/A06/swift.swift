import Foundation

struct MaliciousPayload: Codable {
    let rce: String
}

let evilJSON = """
{"rce": "Process.exec(\"calc.exe\")"}
""".data(using: .utf8)! // Hardcoded malicious input

if let payload = try? JSONDecoder().decode(MaliciousPayload.self, from: evilJSON) {
    print("Executed: \(payload.rce)") // Triggers vuln deserialization
}
