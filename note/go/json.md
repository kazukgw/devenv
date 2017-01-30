jsonのデコード
------

### わたってくるjsonの形式がわかっていて固定の時

```go
// json のフォーマットが決まっている場合
type HogeJson struct {
	Hoge string `json:"hoge"`
	Fuga string `json:"fuga"`
}

func main() {
	json := []byte(`{"hoge": "hogehoge", "fuga": "fugafuga"}`);
	strct := &HogeJson{}
	if err := json.Unmarshal(json, &strct); err != nil {
		// なんか
	}
	// => &strct には データが入っている
}
```

### わたってくるjsonがわからん時

```go
func main() {
    // interface{} として定義する
    var dat map[string]interface{}
    if err := json.Unmarshal(byt, &dat); err != nil {
        panic(err)
    }
    fmt.Println(dat)
}
```
