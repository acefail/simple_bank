postgres:
	docker run --name postgres14 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=123456 -d postgres:14-bullseye
createdb:
	docker exec -it postgres14 createdb --username=root --owner=root bank
dropdb:
	docker exec -it postgres14 psql -U root bank
migrateup:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:123456@localhost:5432/bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
.PHONY: postgres createdb dropdb migrateup migratedown sqlc