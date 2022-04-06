module commands

import net
import js_backend

pub fn admin_userlist_cmd(mut socket net.TcpConn, data string, username string) {
	mut js := js_backend.JsFunc{}
	socket.write_string(js.user_table() + "\r\n") or { 0 }
}