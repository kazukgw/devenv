package main

import "fmt"
import "time"

type Client struct {
	Ch   chan string
	Done chan bool
}

func (c *Client) Listen() {
	for {
		select {
		case msg := <-c.Ch:
			fmt.Println("receive msg: " + msg)
		case <-c.Done:
			return
		}
	}
}

func (c *Client) Write(msg string) {
	select {
	case c.Ch <- msg:
	default:
		fmt.Println("no message")
	}
}

func main() {
	c := Client{
		Ch:   make(chan string),
		Done: make(chan bool),
	}

	go c.Listen()

	for i := 0; i < 10; i++ {
		time.Sleep(1000000000)
		if i == 4 {
			c.Write("")
		} else if i == 6 {
			c.Done <- true
		} else {
			c.Write("hogehgoehgoe")
		}
	}
}
