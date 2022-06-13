-- name: CreateAccount :one
INSERT INTO accounts (
  owner,
  balance,
  currency
) VALUES (
  $1, $2, $3
) RETURNING *;

-- name: GetAccount :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

--name: ListAccounts :many
SELECT * FROM accounts
ORDER BY id 
LIMIT $1
OFFSET $2;

-- name: UpdateAccount :one
UPDATE accounts
SET balance = $2
WHERE id = $1
RETURNING *;

--name: DeleteAccount :exec
DELETE FROM accounts WHERE id = $1;






-- name: CreateEntry :one
INSERT INTO entries (
  account_id,
  amount
) VALUES (
  $1, $2
) RETURNING *;

-- name: GetEntry :one
SELECT * FROM entries
WHERE id = $1 LIMIT 1;

--name: ListEntries :many
SELECT * FROM entries
ORDER BY id 
LIMIT $1
OFFSET $2;

--name: ListEntriesByID :many
SELECT * FROM entries
WHERE account_id = $1 
ORDER BY id
LIMIT $2
OFFSET $3;





-- name: CreateTransfer :one
INSERT INTO transfers (
  from_account_id,
  to_account_id,
  amount
) VALUES (
  $1, $2, $3
) RETURNING *;

-- name: GetTransfer :one
SELECT * FROM transfers
WHERE id = $1 LIMIT 1;

--name: ListTransfers :many
SELECT * FROM transfers
ORDER BY id 
LIMIT $1
OFFSET $2;

--name: ListTransfersByFromID :many
SELECT * FROM transfers
WHERE from_account_id = $1 
ORDER BY id
LIMIT $2
OFFSET $3;

--name: ListTransfersByToID :many
SELECT * FROM transfers
WHERE to_account_id = $1 
ORDER BY id
LIMIT $2
OFFSET $3;