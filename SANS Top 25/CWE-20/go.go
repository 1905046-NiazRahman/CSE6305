package main

import (
    "fmt"
    "strconv"
)

func processNum(input string) error {
    num, err := strconv.ParseUint(input, 10, 64)
    if err != nil {
        return fmt.Errorf("invalid: %v", err)
    }
    fmt.Printf("Number: %d\n", num)
    return nil
}

func main() {
    malicious := "18446744073709551616" // > uint64 max
    if err := processNum(malicious); err != nil {
        fmt.Println("Caught:", err) // Outputs error safely.
    }
}
