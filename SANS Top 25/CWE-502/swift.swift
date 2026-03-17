import Foundation

struct Malicious: Codable {
    let data: [UInt8]
}

let maliciousJSON = """
{"data": [1,2,3,null,true,false]}
""".data(using: .utf8)!

do {
    let decoder = JSONDecoder()
    let result = try decoder.decode(Malicious.self, from: maliciousJSON)
    print("Deserialized: \(result)")  // Won't reach here
} catch {
    print("Runtime error: \(error)")  // "Expected to decode UInt8 but found null"
}
