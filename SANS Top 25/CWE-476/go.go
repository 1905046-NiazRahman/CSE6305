package main
import "fmt"

func main() {
    var ptr *int = nil  // Hardcoded nil
    fmt.Println(*ptr)   // Panic: runtime error: invalid memory address
}
