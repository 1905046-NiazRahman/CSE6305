package main
import "fmt"
func main() {
    buf := make([]byte, 5)  // 5-byte slice
    input := []byte{65, 66, 67, 68, 69, 70, 71, 72}  // 8 bytes
    copy(buf, input)  // Bounded copy
    fmt.Printf("%v\n", buf)
}
