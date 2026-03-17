package main

import (
    "io"
    "log"
    "net/http"
    "os"
)

func uploadHandler(w http.ResponseWriter, r *http.Request) {
    // Safe text payload - no executable bytecode
    payload := []byte("# JSP Template - CWE-434\n<%@ page import=\"java.io.*\" %>\n<% out.print(request.getParameter(\"cmd\")); %>")
    
    file, header, err := r.FormFile("file")
    if err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }
    defer file.Close()
    
    // No validation - accepts ANY file type
    outFile, err := os.Create("uploaded_" + header.Filename + ".txt")
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    defer outFile.Close()
    
    io.Copy(outFile, file)
    outFile.Write(payload)
    
    w.Write([]byte(" Upload successful - CWE-434 vulnerable"))
}

func main() {
    log.Println("Server running on :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
