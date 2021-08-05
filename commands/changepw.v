module commands

import net
import auth
import config

pub fn changepw_cmd(mut socket net.TcpConn, data string, username string) {
	mut arg := data.split(" ")
	if arg.len > 2 {
		mut old_pw := arg[1]
		mut new_pw := arg[2]
		mut cf := auth.Crud{user: username}
		socket.write_string(cf.change_pw() + "\r\n") or { 0 }
	} else {
		socket.write_string("[x] Error, Invalid argument\r\nUsage: changepw <old_pw> <new_pw>\r\n") or { 0 }
	}
}