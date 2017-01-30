+++
summary = "go nil pointer is useful"
tag = ["go"]
+++


```go
package main

import (
	"fmt"
)

type Sample struct {
	*Inner
}

type Inner struct {
	A string
}

func (i *Inner) Echo() {
	if i != nil {
		fmt.Println(i.A)
	} else {
		fmt.Println("hogehgoe")
	}
}

func main() {
	s := Sample{}
	s.Echo()
}
```

Echo を call したときに自分自身(?)がnilかどうかを検査して
実行するかどうかを検査しているので呼び出し側で判別する必要がなくなる
スリムに書ける
