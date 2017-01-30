json ファイルを読みこんで map[string]{}interface にする
======

```go
package main

import (
    "os"
    "fmt"
    "bufio"
    "strings"
    "encoding/json"
    "errors"
)

func readFromFile(filePath string) ([]string, error) {
    var lines []string

    file, err := os.Open(filePath)
    if err != nil {
        return lines, errors.New(filePath +  " がひらけませんでした")
    }
    defer file.Close()

    // cap はテキトウに設定する
    lines = make([]string, 0, 100)
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
      lines = append(lines, scanner.Text())
    }

    if err := scanner.Err(); err != nil {
        return lines, errors.New(filePath + "のスキャンに失敗しました")
    }

    return lines, nil
}

func main() {
  lines, err := readFromFile("/Users/kazukgw/tmp/sample.json")

  if err != nil {
    fmt.Println("エラーじゃぁ〜")
  }

  jsonString := strings.Join(lines, "")

  var jsonStruct map[string]interface{}
  unmarshalErr := json.Unmarshal([]byte(jsonString), &jsonStruct)
  if unmarshalErr != nil {
    fmt.Println("エラーじゃぁ〜")
  }

  fmt.Println(jsonStruct["userId"])
}
```
