package main

import (
	"fmt"
)

func main() {
	arr := []int{1, 4, 10, 5, 8, 11, 2}
	sort(arr)
	fmt.Println(arr)
	// Output: [1 2 4 5 8 10 11]

}

func sort(arr []int) {
	for i, v := range arr {
		insert(arr, i, v)
	}
}

// 整列化領域の一番右(一番大きい)
// 値から順に比較して 自分のほうが大きくなった時点でループを止めて
// そこにinsertする
func insert(arr []int, pos, v int) {
	i := pos - 1
	for ; i >= 0 && arr[i] > v; i-- {
		arr[i+1] = arr[i]
	}
	arr[i+1] = v
}
