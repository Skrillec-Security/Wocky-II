module auth

pub struct AttackCrud {
	pub mut:
		user string
}

// method -> user_conn_up() 
// note -> 
pub fn (mut ac AttackCrud) user_conn_up() {
	mut c := Crud{ac.user}
	mut info := c.userline()
	if info.contains("[x]") { return info }
	info = info.split(",")
	mut new_conn := info[6].int()+1
	c.user_remove()
	mut fd := os.open("/root/Wocky/db/users.db") or { panic("[x] Error, Unable to read USER database!\r\n") }
	fd.write("('${info[0]}','${info[1]}','${info[2]}','${info[3]}','${info[4]}','${info[5]}','${new_conn}','${info[7]}','${info[8]}')\n".bytes())
	fd.close()
}

// method -> user_conn_down() 
// note -> 
pub fn (mut ac AttackCrud) user_conn_down() {
	mut c := Crud{ac.user}
	mut info := c.userline()
	if info.contains("[x]") { return info }
	info = info.split(",")
	mut new_conn := info[6].int()-1
	c.user_remove()
	mut fd := os.open("/root/Wocky/db/users.db") or { panic("[x] Error, Unable to read USER database!\r\n") }
	fd.write("('${info[0]}','${info[1]}','${info[2]}','${info[3]}','${info[4]}','${info[5]}','${new_conn}','${info[7]}','${info[8]}')\n".bytes())
	fd.close()
}