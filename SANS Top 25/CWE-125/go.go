package main
import "fmt"
func main() {
    arr := [5]byte{1, 2, 3, 4, 5}
    slice := arr[:]
    idx := 10  // Hardcoded malicious index
    fmt.Println(slice[idx])  // Panic: runtime error: index out of range [10] with length 5
}
