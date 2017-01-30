+++
summary = "標準入力がttyかどうか"
tag = ["go"]
+++

```go
func isSTDINTTY() bool {
	stat, _ := os.Stdin.Stat()
	return (stat.Mode() & os.ModeCharDevice) != 0
}
```


