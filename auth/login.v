module auth

pub struct Auth {
	pub mut:
		username string
		password string
}

pub fn (mut a Auth) login() ?string {
	mut test := Crud{user: a.username}
 	return test.userline() + " | " + a.password
}