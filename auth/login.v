module auth

pub struct AuthInfo {
	pub mut:
		username string
		password string
}

pub fn (mut a AuthInfo) login() string {
	mut test := Crud{user: a.username}
 	mut check_usr := test.userline()
	mut usr_info := ['']
	if check_usr.contains("[x]") { return check_usr } else { usr_info = check_usr.split(",") }
	if usr_info[0] == (a.username).str() {
		if usr_info[2] == (a.password).str() {
			return "[+] Welcome: ${a.username}\r\n"
		} else {
			return "[x] Error, Username or password seems to be incorrect!\r\n"
		}
	} else {
			return "[x] Error, Username or password seems to be incorrect!\r\n"
	}
}