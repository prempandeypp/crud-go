package main

import (
	"fmt"
	"github.com/prempandeypp/crud-go/app/helper"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func main() {
	fmt.Printf("Start server...")
	routes := httprouter.New()
	server := http.Server{Addr: "localhost:8080", Handler: routes}
	err := server.ListenAndServe()
	helper.PanicIfError(err)

}
