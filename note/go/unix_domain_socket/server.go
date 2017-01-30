package main

import (
	"fmt"
	"net"
	"os"
)

func main() {
	l, err := net.ListenUnix("unix", &net.UnixAddr{"/tmp/unixdomain", "unix"})
	if err != nil {
		panic(err)
	}
	defer os.Remove("/tmp/unixdomain")

	for {
		conn, err := l.AcceptUnix()
		if err != nil {
			panic(err)
		}
		var buf [1024]byte
		n, err := conn.Read(buf[:])
		if err != nil {
			panic(err)
		}
		fmt.Printf("%s\n", string(buf[:n]))
		conn.Close()
	}
}
