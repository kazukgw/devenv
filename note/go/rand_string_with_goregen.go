package main

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/zach-klippenstein/goregen"
)

func gen() (string, error) {
	rand.Seed(time.Now().UnixNano())
	rd, err := regen.Generate("[a-zA-Z0-9]{24}")
	if err != nil {
		return "", err
	}
	return rd, nil
}

func main() {
	if str1, e1 := gen(); e1 == nil {
		fmt.Println(str1)
	}
	if str2, e2 := gen(); e2 == nil {
		fmt.Println(str2)
	}
	if str3, e3 := gen(); e3 == nil {
		fmt.Println(str3)
	}
}
