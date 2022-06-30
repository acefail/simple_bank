package api

import (
	db "postgres/db/sql"

	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/gin/binding"
	"github.com/go-playground/validator/v10"
)

type Server struct {
	store  db.Store
	router *gin.Engine
}

func NewServer(store db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()
	v, ok := binding.Validator.Engine().(*validator.Validate)
	if ok {
		v.RegisterValidation("currency", validCurrency)
	}
	// add routes to router

	router.POST("/accounts", server.createAccount)
	router.GET("/accounts/:id", server.getAccount)
	router.GET("/accounts", server.listAccounts)

	router.POST("/transfers", server.createTransfer)

	router.POST("/users", server.createUser)
	server.router = router
	return server
}

//Start runs HTTP server on a given address
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorRespond(err error) gin.H {
	return gin.H{"error": err.Error()}
}
