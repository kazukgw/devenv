package main

import (
	"github.com/codegangsta/cli"
)

func main() {
	app := cli.NewApp()
	app.Name = "app"
	app.Usage = "app <command> <options>"
	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:  "flag",
			Value: "default_value",
			Usage: "app flag",
		},
	}
	app.Commands = []cli.Command{
		{
			Name:   "command1",
			Usage:  "app command1",
			Action: command1,
			Flags: []cli.Flag{
				flag1,
				flag2,
			},
		},
		{
			Name:   "command2",
			Usage:  "app command2",
			Action: command2,
			Subcommands: []cli.Command{
				{
					Name:   "sub1",
					Usage:  "app command2 sub1",
					Action: sub1,
					Flags: []cli.Flag{
						flagFm,
					},
				},
				{
					Name:   "sub2",
					Usage:  "app command2 sub2",
					Action: sub2,
				},
			},
		},
	}
	app.Run(os.Args)
}

var flag1 = cli.StringFlag{
	Name:  "flag1",
	Value: "default_val", // default
	Usage: "-flag1 value",
}

var flag2 = cli.StringSliceFlag{
	Name:  "flag2",
	Value: &cli.StringSlice{},
	Usage: "-flag2 hoge -flag2 fuga",
}

func command1(c *cli.Context) {
	args := c.Args() // args は 配列になる
	flag1 := c.String("flag1")
	// some action
}

func command2(c *cli.Context) {
	flag2vals := c.StringSlice("flag2")
	// some action
}

func sub1(c *cli.Context) {
	// some action
}

func sub2(c *cli.Context) {

}
