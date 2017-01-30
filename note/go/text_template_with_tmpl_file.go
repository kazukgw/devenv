package main

import (
	"fmt"
	"os"
	"text/template"
)

var d = &struct{ Hoge string }{"Hoge"}

func main() {
	/* -- sample.tmpl --
	 * みなさん！ {{.Hoge}} ですよ！
	 */

	t, err := template.ParseFiles("sample.tmpl")
	if err != nil {
		fmt.Println("err!")
		return
	}
	t.Execute(os.Stdout, d) //=> みなさん! Hoge ですよ！
}
