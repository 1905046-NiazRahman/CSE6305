package main

import "fmt"

func main() {
    // Hardcoded malicious input
    authenticated := false  // No auth check
    
    deleteUserDatabase := func() {
        fmt.Println("Database deleted! Critical function executed without auth.")
    }
    
    deleteUserDatabase()  // Executes freely
}
