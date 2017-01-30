package main

import (
	"fmt"
)

func main() {
	arr := []int{5, 3, 6, 1, 7, 4, 10, 2}
	store := partition(arr, 0, len(arr)-1, 2)

	// sort(arr)
	fmt.Println(arr, store)
	// Output:
}

func sort(arr []int) {
	medianSort(arr, 0, len(arr)-1)
}

func medianSort(arr []int, left, right int) {

}

func partition(arr []int, left, right, pivotIndex int) int {
	pivot := arr[pivotIndex]

	// 一番右端の値とpivotを入れ替え、一旦pivotを右端によせる
	tmp := arr[right]
	arr[right] = pivot
	arr[pivotIndex] = tmp

	// 分割後にpivotが入るべきindexを storeとする
	store := left
	for idx := left; idx < right; idx++ {
		if pivot > arr[idx] {
			// 左から比較していき, pivot より小さい値は
			// 現在のstoreの位置の要素とswapする。
			tmp := arr[idx]
			arr[idx] = arr[store]
			arr[store] = tmp
			// swapしたら storeをインクリメント
			store++
		}
	}

	// 最後に一番右にいれておいた pivotを
	// storeの位置とswapする
	tmp = arr[right]
	arr[right] = arr[store]
	arr[store] = tmp
	return store
}
