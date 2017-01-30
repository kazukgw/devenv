[gojiを読む]
===========

2015-05-30
------

route で設定されたパターンから トライ木 をつくってたんよな
そのトライ木はどうやってつかわれてるんやろ。

もうなんかいろいろ忘れてしまったので

machine という概念がどういう意味で使われてるかを探ろう

```
type routeMachine struct {
	sm     stateMachine
	routes []route
}
```

```
type state struct {
	mode smMode
	bs   [3]byte
	i    int32
}
type stateMachine []state

type smMode uint8
```

state のとこのコメントめっちゃ長いな。

```
This file implements a fast router by encoding a list of routes first into a
pseudo-trie, then encoding that pseudo-trie into a state machine realized as
a routing bytecode.

The most interesting part of this router is not its speed (it is quite fast),
but the guarantees it provides. In a naive router, routes are examined one after
another until a match is found, and this is the programming model we want to
support. For any given request ("GET /hello/carl"), there is a list of
"plausible" routes: routes which match the method ("GET"), and which have a
prefix that is a prefix of the requested path ("/" and "/hello/", for instance,
but not "/foobar"). Patterns also have some amount of arbitrary code associated
with them, which tells us whether or not the route matched. Just like the naive
router, our goal is to call each plausible pattern, in the order they were
added, until we find one that matches. The "fast" part here is being smart about
which non-plausible routes we can skip.

First, we sort routes using a pairwise comparison function: sorting occurs as
normal on the prefixes, with the caveat that a route may not be moved past a
route that might also match the same string. Among other things, this means
we're forced to use particularly dumb sorting algorithms, but it only has to
happen once, and there probably aren't even that many routes to begin with. This
logic appears inline in the router's handle() function.

We then build a pseudo-trie from the sorted list of routes. It's not quite a
normal trie because there are certain routes we cannot reorder around other
routes (since we're providing identical semantics to the naive router), but it's
close enough and the basic idea is the same.

Finally, we lower this psuedo-trie from its tree representation to a state
machine bytecode. The bytecode is pretty simple: it contains up to three bytes,
a choice of a bunch of flags, and an index. The state machine is pretty simple:
if the bytes match the next few bytes after the cursor, the instruction matches,
and the state machine advances to the next instruction. If it does not match, it
jumps to the instruction at the index. Various flags modify this basic behavior,
the documentation for which can be found below.

The thing we're optimizing for here over pretty much everything else is memory
locality. We make an effort to lay out both the trie child selection logic and
the matching of long strings consecutively in memory, making both operations
very cheap. In fact, our matching logic isn't particularly asymptotically good,
but in practice the benefits of memory locality outweigh just about everything
else.

Unfortunately, the code implementing all of this is pretty bad (both inefficient
and hard to read). Maybe someday I'll come and take a second pass at it.
*/
```

全然よくわからん。。。


次は Match やな。

```
// Match is the type of routing matches. It is inserted into C.Env under
// MatchKey when the Mux.Router middleware is invoked. If MatchKey is present at
// route dispatch time, the Handler of the corresponding Match will be called
// instead of performing routing as usual.
//
// By computing a Match and inserting it into the Goji environment as part of a
// middleware stack (see Mux.Router, for instance), it is possible to customize
// Goji's routing behavior or replace it entirely.
type Match struct {
	// Pattern is the Pattern that matched during routing. Will be nil if no
	// route matched (Handler will be set to the Mux's NotFound handler)
	Pattern Pattern
	// The Handler corresponding to the matched pattern.
	Handler Handler
}
```

router に getMatch とかいう メソッドがあってこれも気になるな。

routeMachine に route というメソッドがる。これはただの HTTPMETHODか

なんか想像やけど、↑のメソッドで トライ木 を探索して登録してある
ハンドラを取得して それを route にセットして返してるぽいな
んで getMatch で そのセットされた route を返していると。

なるほどな大体わかってきたぞ。

```
func (m *mStack) newStack() *cStack {
	cs := cStack{}
	router := m.router

	cs.m = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		router.route(&cs.C, w, r) // ここで最後のハンドラをセットしているのか！？
	})
	for i := len(m.stack) - 1; i >= 0; i-- {
		cs.m = m.stack[i].fn(&cs.C, cs.m)
	}

	return &cs
}
```


2015-05-28
------

DefaultMux は いろんな middleware とかつけた状態か。

middleware stack の最後に handler がある。
middleware はそれぞれ ServeHTTP メソッドを持つ(http.Handler)。

普通の http パッケージの http.Handle("/", DefaultMux)

となってるのか。

なるほど。

Mux の ServeHTTP はどうなってるのか

```
// ServeHTTP processes HTTP requests. Satisfies net/http.Handler.
func (m *Mux) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	stack := m.ms.alloc()
	stack.ServeHTTP(w, r)
	m.ms.release(stack)
}
```

なんか struct composition をすごくうまく使ってる感じするな。
ms は middleware stack か。 alloc で stack 用意するわけだ
てことは alloc の最後に handler を inject してるはず

```
func (m *mStack) alloc() *cStack {
	p := m.pool
	cs := p.alloc()
	if cs == nil {
		cs = m.newStack()
	}

	cs.pool = p
	return cs
}
```

pool に実際の middleware がはいってるのか？

```
func (m *mStack) invalidate() {
	m.pool = makeCPool()
}
```

とりあえず makeCPool をのぞくか

```
type cPool sync.Pool

func makeCPool() *cPool {
	return &cPool{}
}

func (c *cPool) alloc() *cStack {
	cs := (*sync.Pool)(c).Get()
	if cs == nil {
		return nil
	}
	return cs.(*cStack)
}

func (c *cPool) release(cs *cStack) {
	(*sync.Pool)(c).Put(cs)
}
```

sync.Pool てなんじゃらほい

```
Pool's purpose is to cache allocated but unused items for later reuse,
relieving pressure on the garbage collector.
That is, it makes it easy to build efficient,
thread-safe free lists. However, it is not suitable for all free lists.
```

GC の 回収されないで 長時間キャッシュする pool か？
thread-safe

```
cStack is a cached middleware stack instance. Constructing a middleware stack
involves a lot of allocations: at the very least each layer will have to close
over the layer after (inside) it and a stack N levels deep will incur at least N
separate allocations. Instead of doing this on every request, we keep a pool of
pre-built stacks around for reuse.
```

mStack と cStack の関係は？

```
func (m *mStack) newStack() *cStack {
	cs := cStack{}
	router := m.router

	cs.m = http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		router.route(&cs.C, w, r)
	})
	for i := len(m.stack) - 1; i >= 0; i-- {
		cs.m = m.stack[i].fn(&cs.C, cs.m)
	}

	return &cs
}
```

成歩ディウス。

mStack を 全部実行して 最後に ハンドラのぶんだけのこしたものを
cached した mStack = cStack として 生成するのか？

ところで Get はこうなってる

```
func (m *Mux) Get(pattern PatternType, handler HandlerType) {
	m.rt.handleUntyped(pattern, mGET|mHEAD, handler)
}
```

rt.handleUntyped

router に handleUntyped とかいう メソッドがあるみたいね？

handleUntyped は handle の ラッパか

```
func (rt *router) handle(p Pattern, m method, h Handler) {
	rt.lock.Lock()
	defer rt.lock.Unlock()

	// Calculate the sorted insertion point, because there's no reason to do
	// swapping hijinks if we're already making a copy. We need to use
	// bubble sort because we can only compare adjacent elements.
	pp := p.Prefix()
	var i int
	for i = len(rt.routes); i > 0; i-- {
		rip := rt.routes[i-1].prefix
		if rip <= pp || strings.HasPrefix(rip, pp) {
			break
		}
	}

	newRoutes := make([]route, len(rt.routes)+1)
	copy(newRoutes, rt.routes[:i])
	newRoutes[i] = route{
		prefix:  pp,
		method:  m,
		pattern: p,
		handler: h,
	}
	copy(newRoutes[i+1:], rt.routes[i:])

	rt.setMachine(nil)
	rt.routes = newRoutes
}
```

handle はただたんに route を slice の先頭に追加したものを
router の routes にセットするだけか。

stateMachine とか routeMachine てなんや

routes は compile されて

TrieTree になるみたいね
トライツリーとは =>
http://ja.wikipedia.org/wiki/%E3%83%88%E3%83%A9%E3%82%A4%E6%9C%A8

```
キーが文字列である連想配列の実装構造として使われる。
2分探索木と異なり、各ノードに個々のキーが格納されるのではなく、
木構造上のノードの位置とキーが対応している。
あるノードの配下の全ノードは、
自身に対応する文字列に共通するプレフィックス（接頭部）があり、
ルート（根）には空の文字列が対応している。
値は一般に全ノードに対応して存在するわけではなく、
末端ノードや一部の中間ノードだけがキーに対応した値を格納している。
```

uri の "/" での区切りの数で ツリーをつくってるのか。


