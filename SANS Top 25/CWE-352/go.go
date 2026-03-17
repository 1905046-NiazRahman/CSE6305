package main

import (
    "encoding/json"
    "net/http"
)

type Transfer struct {
    To    string `json:"to"`
    Amount uint  `json:"amount"`
}

func transferFunds(w http.ResponseWriter, r *http.Request) {
    // Hardcoded forged input
    forged := Transfer{To: "attacker_account", Amount: 1000}
    w.Write([]byte("Transferred " + string(forged.Amount) + " to " + forged.To))
    // No origin/token validation
}

func main() {
    http.HandleFunc("/transfer", transferFunds)
    // http.ListenAndServe(":8080", nil)
}
