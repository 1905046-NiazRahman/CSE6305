package main
import "fmt"
func main() {
    buf := make([]byte, 3)  // Hardcoded buffer of size 3
    buf[5] = 99             // Hardcoded out-of-bounds write
    fmt.Println(buf)        // Panics: index out of range [5] with length 3
}
