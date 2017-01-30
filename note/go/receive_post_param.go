import "github.com/goji/param"

type SignUpFormParams struct {
	Email    string `param:"email"`
	Password string `param:"password"`
}

func CreateUser(c web.C, w http.ResponseWriter, r *http.Request) {
	if rerr := r.ParseForm(); rerr != nil {
		http.Error(w, "No good!", 400)
		return
	}

	params := &SignUpFormParams{}
  if perr := param.Parse(r.PostForm, params); perr != nil {
		http.Error(w, "No good!", 500)
		return
	}
}
