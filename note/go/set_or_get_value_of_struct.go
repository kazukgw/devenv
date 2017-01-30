package main

import (
	"fmt"
	"reflect"
)

type Vertex3 struct {
	X int64
	Y int64
	Z int64
}

func main() {
	v := Vertex3{10, 20, 30}
	vV := reflect.ValueOf(v)

	// by field name
	// get
	x := vV.FieldByName("X").Int()
	fmt.Printf("X = %d\n", x)
	// set
	vPtrV := reflect.ValueOf(&v).Elem()
	vPtrV.FieldByName("X").SetInt(100)
	fmt.Printf("X = %d\n", v.X)

	// by field index
	for i := 0; i < vV.NumField(); i++ {
		fmt.Println(vV.FieldByIndex([]int{i}).Int())
	}
}
