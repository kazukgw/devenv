package main

import "fmt"
import "os/exec"
import "strings"

func main() {
	b, e := exec.Command("bash", "-c", "ip route |  awk '/default/ {print $3}'").Output()
	if e != nil {
		fmt.Println("----- err ------")
		fmt.Println(e.Error())
	} else {
		fmt.Println(strings.Trim(string(b), " \n")) // なんか IP
	}
}
