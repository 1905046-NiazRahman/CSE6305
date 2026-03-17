import SQLite3  // Or GRDB/SQLite.swift package

let db = try Connection("test.db")
let username = "admin'; DROP TABLE users; --"
let stmt = try db.prepare("SELECT * FROM users WHERE username = ? AND active = ?", (username, 1))
print(stmt)  // ? placeholders escape: safe
