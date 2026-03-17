package main
import "fmt"
func main() {
    a := int32(2000000000)
    b := int32(2000000000)
    sum := a + b  // Wraps silently
    fmt.Println("Sum:", sum)  // Sum: -1294967296
}
