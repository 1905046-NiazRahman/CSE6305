package main

import (
    "encoding/json"
    "fmt"
    "net/http"
    "sync"
)

type SessionStore struct {
    mu      sync.RWMutex
    sessions map[string]string
}

func main() {
    store := &SessionStore{sessions: make(map[string]string)}
    
    // Hardcoded malicious session ID from attacker
    attackerSession := "fixed_attacker_session123"
    
    loginHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        store.mu.Lock()
        store.sessions[attackerSession] = "attacker_user"
        store.mu.Unlock()
        json.NewEncoder(w).Encode(map[string]string{
            "message":    "Login success",
            "session_id": attackerSession,
        })
    })
    
    // No stdlib check - vuln exposed
    fmt.Printf("Go: Session fixed to '%s', no built-in protection.\n", attackerSession)
}
