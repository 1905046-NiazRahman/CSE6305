package main

import (
    "bytes"
    "encoding/gob"
    "fmt"
)

type User struct {
    Role string
}

func main() {
    // Hardcoded "legit" serialized user
    legit := User{Role: "user"}
    var legitBytes bytes.Buffer
    gob.NewEncoder(&legitBytes).Encode(legit)
    
    // Tampered bytes: mutate to "admin"
    tamperedBytes := legitBytes.Bytes()
    copy(tamperedBytes[10:15], []byte("admin"))
    
    var malicious User
    gob.NewDecoder(bytes.NewReader(tamperedBytes)).Decode(&malicious)
    fmt.Println(malicious)  // Outputs {admin} - exploit succeeds
}
