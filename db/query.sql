-- name: GetName :one
SELECT *
FROM names
WHERE id = $1;
