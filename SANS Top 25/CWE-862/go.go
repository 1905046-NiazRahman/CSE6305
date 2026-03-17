package main

import (
    "fmt"
    "net/http"
)

var users = map[string]string{
    "admin": "super_secret_data",
    "user1": "normal_data",
}

func handler(w http.ResponseWriter, r *http.Request) {
    currentUser := "user1"    // Hardcoded "authenticated" user (malicious).
    targetUser := r.URL.Query().Get("id") // Simulate input; hardcoded via test call.
    if targetUser == "" {
        targetUser = "admin"  // Hardcoded malicious target.
    }

    // Missing authorization: No check if currentUser can access targetUser.
    if data, ok := users[targetUser]; ok {
        fmt.Fprintf(w, "Accessed %s's data: %s\n", targetUser, data)
    }
}

func main() {
    http.HandleFunc("/data", handler)
    http.ListenAndServe(":8080", nil)
    // Test: curl "localhost:8080/data?id=admin" -> Accessed admin's data: super_secret_data
}
