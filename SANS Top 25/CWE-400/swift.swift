import Foundation
print("Starting...")
var array: [UInt8] = []  // Unbounded Array
let maliciousSize = 1_000_000_000  // Hardcoded huge
for _ in 0..<maliciousSize {
    array.append(0x61)  // Grows until OOM
}
print("Allocated \(array.count) bytes")
