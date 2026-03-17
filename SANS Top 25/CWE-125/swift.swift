import Foundation
let arr = [UInt8]([1, 2, 3, 4, 5])
let idx = 10 as Int  // Hardcoded malicious
print(arr[idx])  // Fatal error: Index out of range
