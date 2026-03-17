package main

import (
	"fmt"
	"os/exec"
)

func main() {
	// Simulated malicious input
	malicious := "somefile; echo MALICIOUS && touch /tmp/hacked_go"

	// Vulnerable pattern: using sh -c and concatenating input
	fullCmd := "ls " + malicious

	fmt.Println("About to run:", fullCmd)

	cmd := exec.Command("sh", "-c", fullCmd)
	output, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Println("Error:", err)
	}
	fmt.Println("Output:\n", string(output))
}
