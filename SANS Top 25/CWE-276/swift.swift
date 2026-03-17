import Foundation

let fm = FileManager.default
// CWE-276: createFile defaults permissive (0666 umask-applied)
try? fm.createFile(atPath: "secret.txt", contents: "sensitive data".data(using: .utf8))
