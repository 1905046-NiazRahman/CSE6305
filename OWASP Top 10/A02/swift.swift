import CryptoKit
import Foundation

func strongHashWithRandomSalt(_ input: String) -> String {
    let salt = Data(randomBytes: 16)     // secure random
    let msg = input.data(using: .utf8)!
    let salted = msg + salt

    let digest = SHA256.hash(data: salted)
    return digest.compactMap { String($0, radix: 16, uppercase: false) }.joined()
}

extension Data {
    init(randomBytes count: Int) {
        self = Data(count: count)
        _ = self.withUnsafeMutableBytes { buffer in
            SecRandomCopyBytes(nil, count, buffer.baseAddress!)
        }
    }
}

func mainSafe() {
    let input = "password123"
    let hash = strongHashWithRandomSalt(input)
    print("Strong hash: \(hash)")
}
