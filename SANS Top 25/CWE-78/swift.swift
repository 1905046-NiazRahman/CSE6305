import Foundation

// Simulated malicious input
let malicious = "somefile; echo MALICIOUS && touch /tmp/hacked_swift"

// Vulnerable pattern: build a shell command line that includes user input
let fullCmd = "ls \(malicious)"
print("About to run: \(fullCmd)")

let process = Process()
process.executableURL = URL(fileURLWithPath: "/bin/sh")
process.arguments = ["-c", fullCmd]

let pipe = Pipe()
process.standardOutput = pipe
process.standardError = pipe

do {
    try process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        print("Output:\n\(output)")
    }
    print("Exit code: \(process.terminationStatus)")
} catch {
    print("Error: \(error)")
}
