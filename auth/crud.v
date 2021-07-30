/*
Custom AUTH Module
@creator: vZy

All function use strings from struct. Set struct strings to use in functions!

Struct: Crud

Functions          | Return Type  | Crud Struct Strings being used
_____________________________________________________________________
userline()         | string       | user
user_register()    | string       | user, pw
user_remove()      | string       | user
user_update()      | string       | user, mtime, conn, admin, expiry
user_ipreset()     | string       | user

==============================================================================================

Struct: RegisterCrud

Functions          | Return Type  | RegisterCrud Struct Strings being used
________________________________________________________________________________
user_register()    | string       | token
create_token()     | string       | N/A
get_token()        | string       | token


*/
module auth

import os

pub struct Crud {
	pub mut:
		user string
		ip string
		pw string
		lvl int
		mtime int
		conn int
		ongoing int
		admin int
		expiry string
}

pub struct RegisterCrud {
	pub mut:
		token string
		lvl int
		mtime int
		conn int
		expiry string
}

/*
method -> userline()
note -> get a user's line from database and return it in commas only
*/
pub fn (mut a Crud) userline() string {
	mut users := os.read_lines('/root/Wocky/db/users.db') or {
		panic("[x] Error, Couldn't read USER database!\r\n")
	}
	for user in users {
		if user.len > 5 {
			if user.contains("('$a.user','") {
				mut i := (((user.replace("('","")).replace("')", "")).replace("','", ",")).split(",")
				a.ip = i[1]
				a.pw = i[2]
				a.lvl = i[3].int()
				a.mtime = i[4].int()
				a.conn = i[5].int()
				a.ongoing = i[6].int()
				a.admin = i[7].int()
				a.expiry = i[8]
				return (((user.replace("('","")).replace("')", "")).replace("','", ",")).replace(" ", "")
			}
		}
	}

	return "[x] Error, Unable to find user!"
}

/*
method -> user_remove()
note -> remove user from database!
*/
pub fn (mut a Crud) user_remove() string {
	mut fd := os.read_lines('/root/Wocky/db/users.db') or {
		panic("[x] Error, Couldn't read USER database!")
	}
	mut found := false
	mut new_db := ''
	for usr in fd {
		if usr.len > 5 {
			if usr.contains("('$a.user','") == false {
				found = true
				new_db += new_db
			}
		}
	}
	if found == true {
		return '[+] User: $a.user successfully removed!\r\n' 
	} else {
		return "[x] Error, Couldn't find user: $a.user to remove\r\n"
	}
}

/*
method -> user_update()
arguments -> usr string, mtime string, conn string, admin string 
*/
pub fn (mut a Crud) user_update(usr string, mtime string, conn string, admin string) string {
	// edit this function later to use struct strings instead of function argument strings
	mut file_d := os.open('/root/Wocky/db/users.db') or {
		panic("[x] Error, Couldn't read USER database!")
	}
	a.user = usr
	mut user_info := a.userline().split(",")
	a.user_remove()
	file_d.write(("('$usr','" + user_info[1] + "','" + user_info[2] + "','" + user_info[3] + "','" + user_info[4] + "','" + user_info[5] + "','" + user_info[6] + "')\n").bytes()) or {
		panic("[x] Error, Couldn't write USER data to database!\r\n")
	}
	file_d.close()
	return "[x] User: $usr successfully updated!\r\n"
}

pub fn (mut a Crud) add_user() string {
	mut check_user := a.userline()
	if check_user.contains("[x]") { return "[x] Error, User is already taken. Choose another username!\r\n" }
	mut ffd := os.open("/root/Wocky/db/users.db") or {
		panic("[x] Error, Couldn't read USER database!")
	}

	ffd.write("('$a.user','none','$a.pw','0','0','0','0','0','0/0/0000')\n".bytes()) or {
		panic("[x] Error, Couldn't write USER data to database!")
	}
	ffd.close()
	return "[+] User: $a.user has been added!\r\n"
}

// ===============================REGISTER SHIT=================================================

/*
method -> user_register()
note -> create new user!
*/
pub fn (mut a RegisterCrud) user_register(usr string, pw string, token string) string {
	// Edit this later for username check
	// add needing a token to register
	// use token stats to register!
	mut a_info := Crud{user: usr, pw: pw}
	mut check_user := a_info.userline()
	if check_user.contains("[x]") { return "[x] Error, User is already taken. Choose another username!\r\n" }
	mut ffd := os.open("/root/Wocky/db/users.db") or {
		panic("[x] Error, Couldn't read USER database!")
	}

	ffd.write("('$usr','none','$pw','0','0','0','0','0','0/0/0000')\n".bytes()) or {
		panic("[x] Error, Couldn't write USER data to database!")
	}
	ffd.close()
	return "[+] User: $usr has been added!\r\n"
}

pub fn (mut a RegisterCrud) tokenline() string {
	mut tokens := os.read_lines('/root/Wocky/db/tokens.db') or {
		panic("[x] Error, Couldn't read TOKEN database!\r\n")
	}

	for token in tokens {
		if token.len > 5 {
			if token.contains("('$a.token','") {
				return ((token.replace("('", "")).replace("')", "")).replace("','", ",")
			}
		}
	}
	return "[x] Error, Unable to find token!\r\n"
}

pub fn (mut a RegisterCrud) token_remove() string {
	mut tokens := os.read_lines('/root/Wocky/db/users.db') or {
		panic("[x] Error, Couldn't read TOKEN database!]r]n")
	}

	for token in tokens {
		if token.len < 5 { break }
	}
	return "[+] Token: $a.token successfully removed!\r\n"
}

// pub fn (mut a RegisterCrud) create_token() string {
// 	mut new_token := os.execute("tr -dc A-Za-z0-9 </dev/urandom | head -c 34 ; echo ''").output
// 	mut fd := open("/root/Wocky/db/tokens.db") or {
// 		panic("[x] Error, Unable to read TOKENS database!\r\n")
// 	}

	
// }