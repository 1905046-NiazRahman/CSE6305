package main
import (
    "fmt"
    "os/exec"
)
func main() {
    input := "ls; cat /etc/passwd"  // Hardcoded malicious input
    cmd := exec.Command("sh", "-c", input)
    output, _ := cmd.Output()
    fmt.Print(string(output))
}
