ssh.Dial

便利メソッドである。
本来は

net.Dial して conn を取得して
conn を NewClientConn に upgrade
して client, chans, reqs を取得して

NewClient とする必要がある。

??

よくわからん

NewClientConn メソッドをみると

```go
// NewClientConn establishes an authenticated SSH connection using c
// as the underlying transport.  The Request and NewChannel channels
// must be serviced or the connection will hang.
```

とある

こみいったのはもう RFCみないとつらいかもなぁ、、、
うーん。
なんかこうもうちょっと外観をみたいんや

------

ssh の仕組みそもそもちゃんとしらんな、、、
とおもったのでちょっとしらべた。

なるほど。

公開鍵と乱数で暗号作成 と ハッシュも作成
秘密鍵で復号してこの乱数をハッシュとして以後は
このハッシュを共通鍵としてsessionを行う。

なるほどね〜
