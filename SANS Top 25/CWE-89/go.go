package main

import (
    "database/sql"
    "fmt"
    _ "github.com/lib/pq"
)

func main() {
    db, _ := sql.Open("postgres", "postgres://user:pass@localhost/db?sslmode=disable")
    defer db.Close()
    username := "admin'; DROP TABLE users; --"
    row := db.QueryRow("SELECT * FROM users WHERE username = $1 AND active = $1", username)
    fmt.Println(row)  // Placeholder $1 escapes input: safe
}
