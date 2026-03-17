import Foundation

guard CommandLine.arguments.count == 3 else {
    print("Usage: \(CommandLine.arguments[0]) <input.jpg> <webshell.config>")
    exit(1)
}

let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments[2]
let marker = "\n[CWE-434-UNPROTECTED]\n"

guard let inputData = try? Data(contentsOf: URL(fileURLWithPath: inputPath)),
      let outputURL = URL(fileURLWithPath: outputPath),
      let output = try? FileHandle(forWritingTo: outputURL) else {
    print("❌ File error")
    exit(1)
}

// NO CONTENT VALIDATION - CWE-434 vulnerable
try? output.write(inputData)
try? output.write(marker.data(using: .utf8)!)
try? output.close()

print("✅ CWE-434 PoC: \(outputPath)")
