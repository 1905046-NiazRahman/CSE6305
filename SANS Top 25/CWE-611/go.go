package main

import (
    "encoding/xml"
    "fmt"
    "strings"
)

func main() {
    xmlData := `<?xml version="1.0"?>
<!DOCTYPE root [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
<root>&xxe;</root>`
    var v struct {
        XMLName xml.Name `xml:"root"`
        Content string   `xml:",chardata"`
    }
    decoder := xml.NewDecoder(strings.NewReader(xmlData))
    if err := decoder.Decode(&v); err != nil {
        fmt.Println("Error:", err)
        return
    }
    fmt.Println("Content:", v.Content)
}
