var hits struct {
    sync.Mutex
    n int
}

hits.Lock()
hits.n++
hits.Unlock()
