
### 名前付き戻り値

```go
func split(sum int) (x, y int) {
  x = sum * 4 / 9
  y = sum = x
  return
}
```

のように引数のあとに各戻り値に型だけでなく
その名前も指定できる。
すると、関数内で同じ名前で指定した変数が戻り値となる。

### 変数宣言

```
var x, y int
```
のように `var` をつかう


```
var i, j int = 1, 2
var c, python, java = true, false, "no!"
```

まとめて初期化子を指定する。
初期化子がリテラルなら、型は省略できる

関数内では、 `:=` という代入文をつかうことで
`var` (及び型宣言)なしで変数を宣言できる

```go
func main() {
  var i, j int = 1, 2
  k := 3
  c, python, java := true, false, "no!"
  fmt.Println(i, j, k, c, python, java)
}
```

### exercise: #24

```
package main

import (
    "fmt"
    "math"
)

func Sqrt(x float64) float64 {
    z := 1.0
    for prev := 1.1; math.Abs(z - prev) > 0.001; {
        prev = z
        z = z - (z*z - x)/2*z
    }
    return z;
}

func main() {
    fmt.Println(Sqrt(2), math.Sqrt(2))
}
```

### 構造体

```
func main() {
  p := Vertex{1, 2}
  q := p
  q.X = 100
  fmt.Println(p) // => {1 2}
  // 構造体のアラタな変数への代入は参照ではなくコピーになる
}

func main() {
  p := Vertex{1, 2}
  q := &p
  q.X = 100
  fmt.Println(p) // => {100 2}
  // 構造体のポインタでアクセスするのがよい
}
```


### slice

slice はmake関数で生成する

SliceはArrayへのポインター、Arrayセグメントの長さ、容量から成る。
なるほど

```
a := make([]int, 5) // len(a) => 5
```

slice は len と cap をもつ

```
a := make([]int, 5, 10) // len(a) => 5
                        // cap(a) => 10
```

```go
func main() {
  p := []int{2, 3, 5, 7, 11, 13}
  fmt.Println("p ==", p)
  fmt.Println("p[1:4] ==", p[1:4])

  q := p[1:4]
  q[1] = 8 // もとは同じ(メモリにある)配列をさす(参照)なので値を
           // 値を書き換えるともとの配列の値も変更される
  fmt.Println(q)
  // missing low index implies 0
  fmt.Println("p[:3] ==", p[:3])
}
/**
  p == [2 3 5 7 11 13]
  p[1:4] == [3 5 7]
  [3 8 7]
  p[:3] == [2 3 8]
*/
```

### Array

数値でindex された 構造体みたいなもん
宣言の仕方がほぼいっしょなので気をつけよう


### excrcise #36

```
package main

import "code.google.com/p/go-tour/pic"

func Pic(dx, dy int) [][]uint8 {
    ret := make([][]uint8, dy, dy)
    for i := range ret {
        ret[i] = make([]uint8, dx, dx)
    }

    for y := 0; y < dy; y++ {
        for x := 0; x < dx; x++ {
            ret[y][x] = uint8((x+y)/2)
        }
    }
  return ret
}

func main() {
    pic.Show(Pic)
}
```

### Maps

```
var m map[string]Vertex

m = make(map[string]Vertex)
m["hoge"] = Vertex{1, 2}

// 値がそんざいするか

elem, ok = m[key]
if ok {
  // => elem がある
}
```

### exercise #41

```
package main

import (
    "fmt"
    "strings"
    "code.google.com/p/go-tour/wc"
)

func WordCount(s string) map[string]int {
    splited := strings.Fields(s)
    fmt.Println(splited)

    ret := make(map[string]int)

    for _, w := range splited {
        count, ok := ret[w]
        if(ok){
            count += 1
        } else {
            count = 1
        }
        ret[w] = count
    }

    return ret
}

func main() {
    wc.Test(WordCount)
}
```

### exercise #44

クロージャをつかってフィボナッチ

```
package main

import "fmt"

// fibonacci is a function that returns
// a function that returns an int.
func fibonacci() func() int {
    prev := 0
    current := 1
    return func () int {
        next := prev + current
        prev = current
        current = next
        return next
    }
}

func main() {
    f := fibonacci()
    for i := 0; i < 10; i++ {
        fmt.Println(f())
    }
}
```

### 構造体のメソッド

```
package main

import (
  "fmt"
  "math"
)

type Vertex struct {
  X, Y float64
}

func (v *Vertex) Abs() float64 {
  return math.Sqrt(v.X * v.X + v.Y * v.Y)
}

func main() {
  v := &Vertex{3, 4}
  fmt.Println(v.Abs())
}
```

なるほど。

上記のようにレシーバにポインタを指定(v *Vertex)
をしないとメソッドの呼び出しのたびに vを新しくコピーするから非効率なのか。


### exercise #56

```
package main

import (
    "fmt"
    "math"
)

type ErrNegativeSqrt float64

func (e ErrNegativeSqrt) Error() string {
    return fmt.Sprintf("cannot Sqrt negativ number: %g", float64(e))
}

func Sqrt(f float64) (float64, error) {
    if f < 0 {
        return 0, ErrNegativeSqrt(f)
    }
    z := 1.0
    for prev := 1.1; math.Abs(z - prev) > 0.001; {
        prev = z
        z = z - (z*z - f)/2*z
    }
    return z, nil
}

func main() {
    fmt.Println(Sqrt(2))
    fmt.Println(Sqrt(-2))
}
```

既存の型を 新しく自分で宣言しなおして
そこにメソッドを追加することで、上記のようにうまくエラーオブジェクトを
つくている。

### 57 webservers



