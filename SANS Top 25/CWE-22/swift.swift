import Foundation

let base = "./uploads"
let userInput = "../../etc/passwd"  // Hardcoded malicious
let path = "\(base)/\(userInput)"

if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
    if let contents = String(data: data, encoding: .utf8) {
        print("Read: \(contents)")
    }
} else {
    print("Error reading file")
}
