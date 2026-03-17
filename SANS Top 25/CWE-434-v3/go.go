package main

import (
    "io"
    "log"
    "net/http"
    "os"
)

func uploadHandler(w http.ResponseWriter, r *http.Request) {
    r.ParseMultipartForm(10 << 20) // 10MB limit
    
    file, header, err := r.FormFile("file")
    if err != nil {
        http.Error(w, err.Error(), 400)
        return
    }
    defer file.Close()
    
    // DANGEROUS: Uses original filename directly
    outFile, err := os.Create("uploads/" + header.Filename)
    if err != nil {
        http.Error(w, err.Error(), 500)
        return
    }
    defer outFile.Close()
    
    // Injects vulnerability marker
    marker := []byte("\n[CWE-434-UNSAFE-UPLOAD]\n")
    io.Copy(outFile, file)
    outFile.Write(marker)
    
    w.Write([]byte("✅ Upload complete: " + header.Filename))
}

func main() {
    os.Mkdir("uploads", 0755)
    log.Fatal(http.ListenAndServe(":8080", nil))
}
