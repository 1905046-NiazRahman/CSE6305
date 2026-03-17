package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	path := "target.txt"
	os.WriteFile(path, []byte("initial"), 0644)

	go func() {
		time.Sleep(50 * time.Millisecond)
		content, _ := os.ReadFile(path)
		if string(content) == "initial" {
			os.WriteFile(path, []byte("raced_by_g1"), 0644)
			fmt.Println("G1 wrote after check")
		}
	}()

	go func() {
		content, _ := os.ReadFile(path)
		if string(content) == "initial" {
			os.WriteFile(path, []byte("raced_by_g2"), 0644)
			fmt.Println("G2 wrote after check")
		}
	}()

	time.Sleep(200 * time.Millisecond)
	content, _ := os.ReadFile(path)
	fmt.Println("Final:", string(content))
}
// Hardcoded input: Goroutines race on file.
// Manual validation: Run (go run); output varies (e.g., "raced_by_g1"), no compile error—logical race succeeds. Race detector (`go run -race`) silent on non-memory race.
