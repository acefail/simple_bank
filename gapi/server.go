package gapi

import (
	"fmt"
	db "postgres/db/sql"
	"postgres/pb"
	"postgres/token"
	"postgres/util"

	"github.com/gin-gonic/gin"
)

type Server struct {
	pb.UnimplementedBankServer
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
	router     *gin.Engine
}

func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}
	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}
