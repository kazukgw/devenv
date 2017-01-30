[go-sql-driver/mysql をよむ]
========

単純に好奇心

--

そのまえに、標準ライブラリの sql とか driver とかを読んどく必要があるよな。
たしか、 標準ライブラリの driver で interface が定義されてて、
それを実装する必要があるんやっけか。

```
// Package driver defines interfaces to be implemented by database
// drivers as used by package sql.
```

sql package でつかわれる driver としての インターフェースを定義してます。

```
// Value is a value that drivers must be able to handle.
// It is either nil or an instance of one of these types:
//
//   int64
//   float64
//   bool
//   []byte
//   string   [*] everywhere except from Rows.Next.
//   time.Time
type Value interface{}
```

これらが、基本の型か。
どのDBでもハンドルされる値はこれらでなければいけない

```
// Driver is the interface that must be implemented by a database
// driver.
type Driver interface {
	// Open returns a new connection to the database.
	// The name is a string in a driver-specific format.
	//
	// Open may return a cached connection (one previously
	// closed), but doing so is unnecessary; the sql package
	// maintains a pool of idle connections for efficient re-use.
	//
	// The returned connection is only used by one goroutine at a
	// time.
	Open(name string) (Conn, error)
}
```

Open は 新しいコネクションをかえす。
sql package がコネクションをキャッシュするので、別に
driver側でキャッシュしなくてもいいよ？ てこと？


```
// Execer is an optional interface that may be implemented by a Conn.
//
// If a Conn does not implement Execer, the sql package's DB.Exec will
// first prepare a query, execute the statement, and then close the
// statement.
//
// Exec may return ErrSkip.
type Execer interface {
	Exec(query string, args []Value) (Result, error)
}

// Queryer is an optional interface that may be implemented by a Conn.
//
// If a Conn does not implement Queryer, the sql package's DB.Query will
// first prepare a query, execute the statement, and then close the
// statement.
//
// Query may return ErrSkip.
type Queryer interface {
	Query(query string, args []Value) (Rows, error)
}
```

オプションでコネクションが実装してもいい。
これを実装しない場合は sql パッケージがかわりにやる。
どういう場合に自分で定義すんねや。 Exec と Query。

```
// Conn is a connection to a database. It is not used concurrently
// by multiple goroutines.
//
// Conn is assumed to be stateful.
type Conn interface {
	// Prepare returns a prepared statement, bound to this connection.
	Prepare(query string) (Stmt, error)

	// Close invalidates and potentially stops any current
	// prepared statements and transactions, marking this
	// connection as no longer in use.
	//
	// Because the sql package maintains a free pool of
	// connections and only calls Close when there's a surplus of
	// idle connections, it shouldn't be necessary for drivers to
	// do their own connection caching.
	Close() error

	// Begin starts and returns a new transaction.
	Begin() (Tx, error)
}
```

Connは複数ごルーチンから同時に使用されることはない。
Prepate と Close とBegin か。

```
// Because the sql package maintains a free pool of
// connections and only calls Close when there's a surplus of
// idle connections, it shouldn't be necessary for drivers to
// do their own connection caching.
```

ドライバでキャッシュしなくてもいいよ〜

--

valueConverter もついでにちょっとよんだ。
driver は独自にこれを実装してもいいし、
標準package のやつをつかってもいいんや?

--

go-sql-driver の方にうつろう。

どこから読もうか。
Openを実装してそうな driver.go からよもう。

Openあったけど、ながいな。
あと driver の packageで

```
import _ "xxxx"
```

てやってるのはなんでなんこれ。

まぁとりあえずいいか。

とおもったら、 init を package に定義しておけば、
これあれなん。
import した時に実行されるんや！？
しらんかた。。。

--

Openをよむ
ふむふむ。 おおまかなやり取りの定義がされているな。
こまかいところは別の関数にそとだし。

- コネクションとなるデータ構造を定義
- 引数で渡されたDSNをパースしてコネクションにセット

- ダイアル

```
// Connect to Server
if dial, ok := dials[mc.cfg.net]; ok {
  mc.netConn, err = dial(mc.cfg.addr)
} else {
  nd := net.Dialer{Timeout: mc.cfg.timeout}
  mc.netConn, err = nd.Dial(mc.cfg.net, mc.cfg.addr)
}
```

すでにコネクションが存在する場合とそうじゃない場合で
わけてる？

- コネクションがTCPなら keepAlive をセット
- バッファを用意してデータのやりとり準備
- Handshakeの最初のパケット(暗号)を読む
- 最初のパケットに返信する(↑の暗号で認証)

認証失敗はとりあえず無視

- 最大packetサイズを取得して必要あれば設定しなおし
- DSNで指定されてたParamをどうにかする

か。

--

つぎは Dial いくか

```
// Dial connects to the address on the named network.
//
// See func Dial for a description of the network and address
// parameters.
```

というかそもそも Dialer なに。

```
// A Dialer contains options for connecting to an address.
//
// The zero value for each field is equivalent to dialing
// without that option. Dialing with the zero value of Dialer
// is therefore equivalent to just calling the Dial function.
type Dialer struct {
	// Timeout is the maximum amount of time a dial will wait for
	// a connect to complete. If Deadline is also set, it may fail
	// earlier.
	//
	// The default is no timeout.
	//
	// With or without a timeout, the operating system may impose
	// its own earlier timeout. For instance, TCP timeouts are
	// often around 3 minutes.
	Timeout time.Duration

	// Deadline is the absolute point in time after which dials
	// will fail. If Timeout is set, it may fail earlier.
	// Zero means no deadline, or dependent on the operating system
	// as with the Timeout option.
	Deadline time.Time

	// LocalAddr is the local address to use when dialing an
	// address. The address must be of a compatible type for the
	// network being dialed.
	// If nil, a local address is automatically chosen.
	LocalAddr Addr

	// DualStack allows a single dial to attempt to establish
	// multiple IPv4 and IPv6 connections and to return the first
	// established connection when the network is "tcp" and the
	// destination is a host name that has multiple address family
	// DNS records.
	DualStack bool

	// KeepAlive specifies the keep-alive period for an active
	// network connection.
	// If zero, keep-alives are not enabled. Network protocols
	// that do not support keep-alives ignore this field.
	KeepAlive time.Duration
}
```

DualStack が true で DNS に IPv4 と IPv6 両方指定されている時には、
一回のダイアルで IPv4 と IPv6 両方でつなぎにいって早いほうで解決する

--

resolveAddr から resolveInternetAddress へ
ざっとみたけど、基本的に DNSパースして
それぞれのアドレス構造体を返すだけか。
んでその構造体は net/dial に定義されていると。

--

dialSingle へいく
なるほど。それぞれのAddressの構造体別に
dialTCP など 関数をわけて実行している。

なんかやっぱり unix 系のネットワークの仕組みらへん
ちゃんと理解していない感じあるわ、、、

--

Conn は net/net.go で定義されているやつ。

--

気づいたら自分の転職について考えてた、、、
いったん中断

--

readInitPacket

速攻 readPacket


