package main

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"strconv"

	"github.com/jackc/pgx/v5"
	"kevinmchugh.me/names/db"
)

type Server struct {
	Queries db.Queries
}

func main() {
	ctx := context.Background()

	// host=localhost user=%s_user password=%s_user dbname=%s application_name=%s"
	conn, err := pgx.Connect(ctx, "host=db password=names user=names dbname=namesdb")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer conn.Close(ctx)
	queries := db.New(conn)
	s := Server{
		Queries: *queries,
	}
	http.HandleFunc("/", s.HelloServer)
	http.ListenAndServe(":8080", nil)

}

func (s Server) HelloServer(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(r.URL.Path[1:])
	if err != nil {
		id = 0
	}
	nameRec, err := s.Queries.GetName(r.Context(), int64(id))

	name := nameRec.Name.String

	if err != nil {
		name = "World!!"
	}

	fmt.Fprintf(w, "Hello, %s!", name)
}
