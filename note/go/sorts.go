package main

import "fmt"

func bubblesort(a []int) {
	l := len(a)
	for pass := l - 1; pass >= 0; pass-- {
		for i := 0; i < pass; i++ {
			if a[i] > a[i+1] {
				a[i], a[i+1] = a[i+1], a[i]
			}
		}
	}
}

func selection(a []int) {
	l := len(a)
	for i := 0; i < l; i++ {
		min := i
		for j := i + 1; j < l; j++ {
			if a[j] < a[i] {
				min = j
			}
		}
		a[min], a[i] = a[i], a[min]
	}
}

func insertionsort(a []int) {
	l := len(a)
	var i, v, j int
	for i = 2; i < l-1; i++ {
		v = a[i]
		j = i
		for a[j-1] > v && j >= 1 {
			a[j] = a[j-1]
			j--
		}
		a[j] = v
	}
}

func merge(a []int, temp []int, left, mid, right int) {
	leftEnd := mid - 1
	tempPos := left
	size := right - left + 1
	// left と right にわかれた2つの要素から先頭を取り出し
	// 比較して 小さいほうを tempの先頭にいれる
	for left <= leftEnd && mid <= right {
		if a[left] <= a[mid] {
			temp[tempPos] = a[left]
			tempPos = tempPos + 1
			left = left + 1
		} else {
			temp[tempPos] = a[mid]
			tempPos = tempPos + 1
			mid = mid + 1
		}
	}

	// left, right のそれぞれのこったほうを tempにいれる
	for left <= leftEnd {
		temp[tempPos] = a[left]
		left = left + 1
		tempPos = tempPos + 1
	}
	for mid <= right {
		temp[tempPos] = a[mid]
		mid = mid + 1
		tempPos = tempPos + 1
	}

	// temp から 元の配列にいれなおす
	for i := 0; i < size; i++ {
		a[right] = temp[right]
		right = right - 1
	}
}

func mergesort(a []int, temp []int, left, right int) {
	var mid int
	if right > left {
		mid = (right + left) / 2
		mergesort(a, temp, left, mid)
		mergesort(a, temp, mid+1, right)
		merge(a, temp, left, mid+1, right)
	}
}

func main() {
	a := []int{1, 2, 3233, 4000, 79, 4, 1, 9, 10, 300, 12, 135, 1000}
	// bubblesort(a)
	// selection(a)
	// insertionsort(a)
	mergesort(a, make([]int, len(a)), 0, len(a)-1)
	fmt.Println(a)
}
