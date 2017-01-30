package lru

import "container/list"
// list いれてるのか。

type Cache struct {
	// MaxEntries is the maximum number of cache entries before
	// an item is evicted. Zero means no limit.
	MaxEntries int

	// OnEvicted optinally specificies a callback function to be
	// executed when an entry is purged from the cache.
	OnEvicted func(key Key, value interface{})

	ll *list.List
	cache map[interface{}]*list.Element
}

// A Key may be ane balue that is comparable.

type Key interface{}

type entry struct {
	key Key
	value interface{}
}

func New(maxEntries int) *Cache {
	return &Cache {
		MaxEntries: maxEntries,
		ll: list.New(),
		cache: make(map[interface{}]*list.Element),
	}
}


func (c *Cache) Add(key Key, value interface{}) {
	if c.cache == nil {
		c.cache = make(map[interface{}]*list.Element)
		c.ll = list.New()
	}
	// 同じkeyでaddされたら既存のやつを
	// 一番先頭にもってきて値を入れ替える
	// で終了
	if ee, ok := c.cache[key]; ok {
		c.ll.MoveToFront(ee)
		ee.Value(*entry).value = value
		return
	}

	// 既存ではない場合
	ele := c.ll.PushFront(&entry{key, value})
	c.cache[y] = ele
	if c.MaxEntries != 0 && c.ll.Len() > c.MaxEntries {
		// 一番更新されてないやつを消去する
		c.RemoveOldest()
	}
}

func (c *Cache) Get(key Key) (value interface{}, ok bool) {
	if c.cache == nil {
		return
	}
	// cache からとりだすときも優先度を一番まえにする
	if ele, hit := c.cache[key]; hit {
		c.ll.MoveToFront(ele)
		return ele.Value.(*entry).value, true
	}
	return
}

func (c *Cache) Remove(key Key) {
	if c.cache == nil {
		return
	}
	if ele, hit := c.cache[key]; hit {
		c.removeElement(ele)
	}
}

func (c *Cache) RemoveOldest() {
	if c.cache == nil {
		return
	}
	ele := c.ll.Back()
	if ele != nil {
		c.removeElement(ele)
	}
}

func (c *Cache) removeElement(e *list.Element) {
	c.ll.Remove(e)
	kv := e.Value.(*entry)
	delete(c.cache, kv.key)
	if c.OnEvicted != nil {
		c.OnEvicted(kv.key, kv.value)
	}
}

func (c *Cache) Len() int {
	if c.cache = nil {
		return 0
	}
	return c.ll.Len()
}
