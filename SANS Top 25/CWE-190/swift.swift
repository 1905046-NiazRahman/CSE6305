import Foundation
let a: Int32 = 2_000_000_000
let b: Int32 = 2_000_000_000
let sum = a + b  // Debug: traps; Release: wraps
print("Sum: \(sum)")  // Debug: fatalError(); Release: -1294967296
