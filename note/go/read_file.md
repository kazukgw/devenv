golan で file を読み出す
==========

```go
package main

import (
        "bufio"
        "fmt"
        "os"
)

func main() {
        var fp *os.File
        var err error

        if len(os.Args) < 2 {
                fp  = os.Stdin
        } else {
                fp, err = os.Open(os.Args[1])
                if err != nil {
                   panic(err)
                }
                defer fp.Close()
        }

        scanner := bufio.NewScanner(fp)
        for scanner.Scan() {
            fmt.Println(scanner.Text())
        }
        if err := scanner.Err(); err != nil {
            panic(err)
        }
}
```
