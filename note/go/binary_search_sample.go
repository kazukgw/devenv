package main

import "fmt"

func main() {
	data := []int{0, 1, 3, 7, 9, 10, 12, 15, 19, 31, 35, 40, 43, 48}
	search := 16
	lo := 0
	hi := len(data) - 1
	cnt := 0
	for lo < hi {
		mid := lo + ((lo + hi) / 2)
		if data[mid] < search {
			lo = mid + 1
		} else {
			hi = mid
		}
	}
	if lo < len(data) && data[lo] == search {
		fmt.Println("found!")
	} else {
		fmt.Println("not found!")
	}
}
