package main

import "fmt"

type User struct {
    ID   int
    Data string
}

func getUserData(users []User, userID int) *string {
    // Vulnerable: Ignores userID, returns admin data
    return &users[1].Data  // Hardcoded index bypass
}

func main() {
    users := []User{
        {ID: 1, Data: "User data"},
        {ID: 2, Data: "Admin secrets"},
    }
    data := getUserData(users, 1)  // Input 1, gets admin
    fmt.Println(*data)  // Outputs: Admin secrets
}
