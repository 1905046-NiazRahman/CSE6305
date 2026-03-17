import Foundation

// Safe template payload
let safePayload = """
# Perl CGI Template - CWE-434 Demo
# print `$_GET{cmd}`;
"""

guard CommandLine.arguments.count == 3 else {
    print("Usage: \(CommandLine.arguments[0]) <input> <shell.txt>")
    exit(1)
}

let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments[2]

guard let inputData = try? Data(contentsOf: URL(fileURLWithPath: inputPath)),
      let output = try? FileHandle(forWritingTo: URL(fileURLWithPath: outputPath)) else {
    print(" File error")
    exit(1)
}

// NO VALIDATION - CWE-434 vulnerable
try? output.write(inputData)
try? output.write(safePayload.data(using: .utf8))

try? output.close()
print(" CWE-434 PoC: \(outputPath) created")
