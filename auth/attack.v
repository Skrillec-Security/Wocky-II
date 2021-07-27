module auth

import auth
import os

pub struct AttackCrud {
	pub mut:
		user string
}

// method -> user_conn_up() 
// note -> 
pub fn (mut ac AttackCrud) user_conn_up() {
	mut c := auth.Crud{user: ac.user}
	mut info_check := c.userline()
	if info_check.contains("[x]") { return }
	mut info := info_check.split(",")
	mut new_conn := info[6].int()+1
	c.user_remove()
	mut fd := os.open("/root/Wocky/db/users.db") or { panic("[x] Error, Unable to read USER database!\r\n") }
	fd.write("('${info[0]}','${info[1]}','${info[2]}','${info[3]}','${info[4]}','${info[5]}','${new_conn}','${info[7]}','${info[8]}')\n".bytes()) or { panic("[x] Error, Unable to read USER database!\r\n") }
	fd.close()
}
// method -> user_conn_down() 
// note -> 
pub fn (mut ac AttackCrud) user_conn_down() {
	mut c := auth.Crud{user: ac.user}
	mut info_check := c.userline()
	if info_check.contains("[x]") { return }
	mut info := info_check.split(",")
	mut new_conn := info[6].int()-1
	c.user_remove()
	mut fd := os.open("/root/Wocky/db/users.db") or { panic("[x] Error, Unable to read USER database!\r\n") }
	fd.write("('${info[0]}','${info[1]}','${info[2]}','${info[3]}','${info[4]}','${info[5]}','${new_conn}','${info[7]}','${info[8]}')\n".bytes()) or { panic("[x] Error, Unable to read USER database!\r\n")}
	fd.close()
}