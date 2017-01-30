package main

import "fmt"

func bomberzero(a [][]int) {
	m := len(a)
	n := len(a[0])
	rows := make([]int, 0)
	cols := make([]int, 0)
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if a[i][j] == 0 {
				cols = append(cols, i)
				rows = append(rows, j)
			}
		}
	}
	for i := 0; i < len(rows); i++ {
		for j := 0; j < n; j++ {
			a[rows[i]][j] = 0
		}
	}
	for i := 0; i < len(cols); i++ {
		for j := 0; j < m; j++ {
			a[j][cols[i]] = 0
		}
	}
}

func main() {
	a := [][]int{
		[]int{1, 2, 3, 4, 5, 6},
		[]int{1, 2, 3, 4, 5, 6},
		[]int{1, 2, 0, 4, 5, 6},
		[]int{1, 2, 3, 4, 5, 6},
		[]int{1, 2, 3, 4, 0, 6},
		[]int{1, 2, 3, 4, 5, 6},
	}

	bomberzero(a)

	for i := 0; i < len(a); i++ {
		fmt.Println(a[i])
	}
}
