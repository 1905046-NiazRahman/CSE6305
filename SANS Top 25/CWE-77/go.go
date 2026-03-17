package main
import (
    "fmt"
    "os/exec"
)
func main() {
    input := "; rm -rf /"  // Hardcoded, but separate arg prevents injection
    cmd := exec.Command("ls", input)
    output, _ := cmd.Output()
    fmt.Println(string(output))
}
