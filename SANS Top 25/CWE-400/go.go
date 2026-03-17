package main
import "fmt"
func main() {
    var s []byte  // Unbounded slice
    maliciousSize := 1000000000  // Hardcoded huge
    for i := 0; i < maliciousSize; i++ {
        s = append(s, byte('a'))  // Grows until OOM
    }
    fmt.Println("Allocated", len(s), "bytes")
}
