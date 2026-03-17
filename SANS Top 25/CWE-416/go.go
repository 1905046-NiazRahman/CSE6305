package main
import (
    "fmt"
    "runtime"
    "unsafe"
)

func main() {
    p := new(int)
    *p = 42
    runtime.GC()  // May trigger collection
    ptr := uintptr(unsafe.Pointer(p))
    q := (*int)(unsafe.Pointer(ptr))
    fmt.Println(*q)  // Potential UAF if GC freed it
}
