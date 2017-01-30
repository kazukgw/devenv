package main

import (
	"fmt"
	"io"
	"net/http"

	gq "github.com/PuerkitoBio/goquery"
	"golang.org/x/text/encoding/japanese"
	"golang.org/x/text/transform"
)

var URL = "http://www.kyounoryouri.jp/index.php?flow=recipe_fit_search_result&type=all&keyword=大根&exclude_keyword="

func main() {
	resp, err := http.Get(URL)
	if err != nil {
		panic(err.Error())
	}

	decoder := NewDecoder(resp.Body)
	doc, _ := gq.NewDocumentFromReader(decoder)
	doc.Find(".box_hub_recipe01").Each(func(_ int, s *gq.Selection) {
		fmt.Println(s.Find(".recipeTitle a").Text())
		fmt.Println(s.Find(".recipeTitle a").Attr("href"))
	})
}

func NewDecoder(reader io.Reader) *transform.Reader {
	return transform.NewReader(reader, japanese.ShiftJIS.NewDecoder())
}
