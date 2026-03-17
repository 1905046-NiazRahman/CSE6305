import Foundation

class DataHolder {
    var value: Int = 42
    deinit { print("Deallocated") }
}

func useAfterFree() {
    var holder: DataHolder? = DataHolder()
    let ptr = withUnsafeMutablePointer(to: &holder) { $0 }
    holder = nil  // ARC may deallocate
    ptr.pointee?.value  // Potential UAF
    print("Accessed")
}
useAfterFree()
