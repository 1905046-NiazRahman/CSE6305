import Foundation
let buf = Array(repeating: UInt8(0), count: 3)  // Hardcoded buffer of size 3
var mutableBuf = buf
mutableBuf[5] = 99  // Hardcoded out-of-bounds write
print(mutableBuf)   // Fatal error: Index out of range
