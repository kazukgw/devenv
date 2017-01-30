## 基本

```go
package main

import (
    "os"
    "text/template"
)

func main() {
    tmpl := "Hello, {{.template}}!"
    t := template.New("t")
    template.Must(t.Parse(tmpl))
    t.Execute(os.Stdout, map[string]string{"template": "World"})
}
```

ちなみに、template.Must(t.Parse(tmpl))は以下のショートカット

```go
_, err := t.Parse(tmpl)
if err != nil {
    panic(err)
}
```

## 変数展開

通常はmapのキーかstructのメンバを.Keyのように
ドット付きで指定するとでその値が展開される。
ただし、該当するキーが見つからなかった場合、
mapでは<no value>という文字列が出力されるが、structではエラーになる。

```
type T struct {
    Name string
}

tmpl := "Hello, {{.Name}}!\n"
t := template.New("t")
template.Must(t.Parse(tmpl))

t.Execute(os.Stdout, map[string]string{"Name": "map"})
t.Execute(os.Stdout, T{Name: "struct"})
t.Execute(os.Stdout, &T{Name: "struct reference"})
```

.のようにドットだけを渡すと変数それ自体が展開される。

```
tmpl := "Hello, {{.}}!\n"
t := template.New("t")
template.Must(t.Parse(tmpl))
t.Execute(os.Stdout, "World")
```

## 関数呼び出し

関数はシェルのパイプのように連結させて呼びだせる。
テンプレート内で呼ぶ関数はtemplate.FuncMapで渡す。

```
tmpl := `Now {{now}}, {{"hello" | toupper}}`
t := template.New("t")
t.Funcs(template.FuncMap{
    "now":     func() string { return time.Now().String() },
    "toupper": strings.ToUpper,
})
template.Must(t.Parse(tmpl))
t.Execute(os.Stdout, nil) // => Now 2013-11-19 19:17:51.378063751 +0900 JST, HELLO
```

## ループ

組み込みのrange Actionをつかえばよい。

```
type T struct{ Name string }
tmpl := `
{{range .}}- {{.Name}}
{{end}}
`
t := template.New("t")
template.Must(t.Parse(tmpl))
t.Execute(os.Stdout, []T{
    {Name: "Alice"},
    {Name: "Bob"},
    {Name: "Charlie"},
    {Name: "Dave"},
})
```

その他、条件分岐等のActionは マニュアルのActionsの 参照

組み込み関数
こちらも マニュアルのFunctionsの項 を参照


