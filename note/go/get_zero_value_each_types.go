package main

import (
	"fmt"
	"reflect"
)

func main() {
	// 文字列 の ゼロ値 == 空文字 を取得
	str := reflect.ValueOf("hoge")
	fmt.Println(reflect.Zero(str.Type()).String()) //=> ""

	// int の ゼロ値 == 0 を取得
	i := reflect.ValueOf(0)
	fmt.Println(reflect.Zero(i.Type()).Int()) //=> 0

	// 構造体
	type Human struct{ Name string }
	st := reflect.ValueOf(&Human{"John"})
	hu, _ := reflect.Zero(st.Type()).Interface().(*Human)
	fmt.Println(hu) //=> nil
}
