package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Full Cycle Rocks!!")
}

func main() {
	port := "8080"

	http.HandleFunc("/", handler)
	fmt.Printf("Server running on port %s...\n", port)
	http.ListenAndServe(":"+port, nil)
}