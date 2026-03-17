import Foundation

struct User: Codable {
    var role: String
}

let jsonData = """
{"role": "user"}
""".data(using: .utf8)!

// Tamper hardcoded JSON bytes directly
var tamperedData = jsonData!
tamperedData.withUnsafeMutableBytes {
    let bytes = $0.bindMemory(to: UInt8.self)
    bytes[10] = 97  // 'a'
    bytes[11] = 100 // 'd'
    bytes[12] = 109 // 'm'
    bytes[13] = 105 // 'i'
    bytes[14] = 110 // 'n'
}

do {
    let malicious = try JSONDecoder().decode(User.self, from: tamperedData)
    print(malicious)  // Prints User(role: "admin") - exploit succeeds
} catch {
    print("No error")
}
