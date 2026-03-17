package main

import (
    "crypto/rand"
    "crypto/sha256"
    "fmt"
)

func strongHashWithSalt(password string) []byte {
    salt := make([]byte, 16)
    _, _ = rand.Read(salt) // secure CSPRNG

    h := sha256.New()
    h.Write([]byte(password))
    h.Write(salt)
    return h.Sum(nil)
}

func main() {
    input := "password123"
    hash := strongHashWithSalt(input)
    fmt.Printf("Strong hash: %x\n", hash)
}
