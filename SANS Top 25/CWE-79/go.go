package main
import "fmt"
func main() {
    maliciousInput := "<script>alert('XSS')</script>"
    response := fmt.Sprintf("Welcome, user: %s", maliciousInput)  // No auto-escape
    fmt.Println(response)  // Outputs raw payload; vulnerable in http.ResponseWriter
}
