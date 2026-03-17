import Foundation
let input = "; rm -rf /"  // Separate arg
let task = Process()
task.executableURL = URL(fileURLWithPath: "/bin/ls")
task.arguments = [input]
try? task.run()
task.waitUntilExit()
