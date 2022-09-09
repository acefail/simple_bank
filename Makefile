DB_URL=postgresql://root:123456@localhost:5432/bank?sslmode=disable

network:
	docker network create bank-network
postgres:
	docker run --name postgres14 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123456 -d postgres:14-bullseye
createdb:
	docker exec -it postgres14 createdb --username=root --owner=root bank
dropdb:
	docker exec -it postgres14 psql -U root bank
migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up
migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1
migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down
migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen -destination db/mock/store.go postgres/db/sql Store
db_docs:
	dbdocs build doc/db.dbml
db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml
proto:
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
    --go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
    proto/*.proto
evans:
	evans --host localhost --port 8081 -r repl
.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 test server mock  db_docs db_schema proto evans