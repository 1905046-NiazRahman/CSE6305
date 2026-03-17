import Foundation
let buf = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: 5)
buf.initialize(repeating: 0, count: 5)
let input = [65, 66, 67, 68, 69, 70, 71, 72] as [UInt8]  // 8 bytes
buf.assign(repeating: 0)  // Safe init
input.withUnsafeBytes { ptr in
    ptr.copyBytes(to: buf.baseAddress!, count: input.count)  // Runtime-checked
}
print(buf.map { String(format: "%c", $0) })
buf.deallocate()
