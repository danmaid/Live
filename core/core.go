package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	port := flag.String("p", "6969", "port")
	flag.Parse()
	fmt.Println("Port:", *port)

	broker := server.NewServer()
	go func() {
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			fmt.Println(scanner.Text())
			broker.Push <- []byte(scanner.Text())
		}
		// for {
		// 	time.Sleep(time.Second * 2)
		// 	broker.Push <- []byte(time.Now().String())
		// }
	}()
	http.Handle("/sse", broker)
	http.Handle("/", http.FileServer(http.Dir("public")))
	addr := ":" + *port
	if err := http.ListenAndServe(addr, nil); err != nil {
		log.Fatal("HTTP server error: ", err)
	}
}
