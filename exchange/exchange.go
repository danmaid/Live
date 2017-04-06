package main

import (
	"bufio"
	"log"
	"net/http"
	"strings"
)

func main() {
	resp, err := http.Get("http://localhost:6969/sse")
	if err != nil {
		log.Fatal(err)
	}
	log.Println("connected")
	defer resp.Body.Close()

	scanner := bufio.NewScanner(resp.Body)
	scanner.Split(sseSplitFunc)

	for scanner.Scan() {
		log.Println("resp: " + scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		panic(err)
	}
}

/**
 * SSE データフォーマットセパレータ
 * data: で始まって \n\n で終わる
 */
func sseSplitFunc(data []byte, atEOF bool) (advance int, token []byte, err error) {
	if atEOF && len(data) == 0 {
		return 0, nil, nil
	}

	if s := strings.Index(string(data), "data: "); s >= 0 {
		data = data[s+6:]
		if e := strings.Index(string(data), "\n\n"); e >= 0 {
			return e + 8, data[0:e], nil
		}
	}

	return 0, nil, nil
}
