package main

import (
	"net"
	"os"
)

func main() {
	typ := "unix" // or "unixgram" or "unixpacket"
	laddr := net.UnixAddr{"/tmp/unixdomaincli", typ}
	conn, err := net.DialUnix(
		typ,
		&laddr, /*can be nil*/
		&net.UnixAddr{"/tmp/unixdomain", typ},
	)
	if err != nil {
		panic(err)
	}
	defer os.Remove("/tmp/unixdomaincli")

	_, err = conn.Write([]byte("hello"))
	if err != nil {
		panic(err)
	}
	conn.Close()
}
