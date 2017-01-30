クイックソート

```go
package main

import (
	"fmt"
)

func main() {
	ary := []int{2,3,2,3,2,311,11,11,11,11,11,11,1,2,3,4,5}
	fmt.Println(qsort(ary))
}

func qsort(ary []int) []int {
	if len(ary) < 2 {
		return ary
	}
	pIdx := len(ary) - 1
	p := ary[pIdx]
	leftIdx := 0
	for i, _ := range ary {
		if ary[i] < p {
			ary[i], ary[leftIdx] = ary[leftIdx], ary[i]
			leftIdx++
		}
	}
  // 自分で書いたけどこれで重複対応できてるのがなんかわかるような
  // わからんような、、、
	for ;leftIdx < len(ary) - 1 && ary[leftIdx] == ary[pIdx]; leftIdx++ {}
	ary[leftIdx], ary[pIdx] = ary[pIdx], ary[leftIdx]
	qsort(ary[:leftIdx])
	qsort(ary[leftIdx:])
	return ary
}
```
