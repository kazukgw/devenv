package main

import "fmt"

func rotate(img [][]int) {
	l := len(img)
	li := l - 1
	for i := 0; i < l/2; i++ {
		for j := i; j < l-i*2-1; j++ {
			// 上, 右, 下, 左 = 左, 上, 右, 下
			img[i][j], img[j][li-i], img[li-i][li-j], img[li-j][i] =
				img[li-j][i], img[i][j], img[j][li-i], img[li-i][li-j]
		}
	}
}

func main() {
	img := [][]int{
		[]int{11, 12, 13, 14, 15, 16},
		[]int{21, 22, 23, 24, 25, 26},
		[]int{31, 32, 33, 34, 35, 36},
		[]int{41, 42, 43, 44, 45, 46},
		[]int{51, 52, 53, 54, 55, 56},
		[]int{61, 62, 63, 64, 65, 66},
	}

	rotate(img)

	for i := 0; i < len(img); i++ {
		fmt.Println(img[i])
	}
}
