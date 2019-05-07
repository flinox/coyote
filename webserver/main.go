package main

import (
	"os"
	"net/http"
	"log"
)

func main() {

	fs := http.FileServer(http.Dir("/tests"))
	http.Handle("/", http.StripPrefix("/", fs))

	port := os.Getenv("WEBSERVERPORT")
	if port == "" {
		//os.Setenv("WEBSERVERPORT", "8000")
		port = "8000"
	}

	log.Printf("Webserver running on port %s",port)

	if err := http.ListenAndServe(":"+port, nil); err != nil {
		panic(err)
		log.Print(err)
	  }

}