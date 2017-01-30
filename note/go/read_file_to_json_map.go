package main

import (
	"bufio"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"strings"
)

func readFromFile(filePath string) ([]string, error) {
	var lines []string

	file, err := os.Open(filePath)
	if err != nil {
		return lines, errors.New(filePath + " がひらけませんでした")
	}
	defer file.Close()

	// cap はテキトウに設定する
	lines = make([]string, 0, 100)
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		return lines, errors.New(filePath + "のスキャンに失敗しました")
	}

	return lines, nil
}

type JsonStruct struct {
	UserId int    `json:"userId"`
	SipId  string `json:"sipId"`
	XmppId string `json:"xmppId"`
}

func main() {
	lines, err := readFromFile("/Users/kazukgw/tmp/sample.json")

	if err != nil {
		fmt.Println("エラーじゃぁ〜")
	}

	jsonString := strings.Join(lines, "")

	//var jsonStruct map[string]interface{}

	var jsonStruct JsonStruct
	unmarshalErr := json.Unmarshal([]byte(jsonString), &jsonStruct)
	if unmarshalErr != nil {
		fmt.Println("エラーじゃぁ〜")
	}

	fmt.Println(jsonStruct["userId"])
}
