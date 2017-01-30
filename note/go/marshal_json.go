package main

import "fmt"
import "encoding/json"

func main() {
	m := map[string]interface{}{
		"hoge": 123,
		"fuga": "hoge",
		"map": map[string]interface{}{
			"hogehoge": "hgoehoe",
		},
	}

	b, err := json.Marshal(m)
	if err != nil {
		fmt.Println("エラーじゃー")
	}

	fmt.Println(string(b[:]))
}
