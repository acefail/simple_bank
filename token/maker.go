package token

import "time"

//Maker interface for managing token
type Maker interface {
	//CreateToken creates a new token for a specific username and valid duration
	CreateToken(username string, duration time.Duration) (string, *Payload, error)

	// VerifyToken checks if a token is valid or not
	VerifyToken(token string) (*Payload, error)
}
