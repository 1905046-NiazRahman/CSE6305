import Foundation

func processLength(_ input: String) -> String {
    guard let length = UInt64(input) else {
        return "Invalid length"
    }
    print("Length: \(length)")
    return "OK"
}

let malicious = "18446744073709551616" // > UInt64.max
print(processLength(malicious)) // Manual test: Outputs "Invalid length" safely.
