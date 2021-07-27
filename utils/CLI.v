module utils

import net

pub struct CLI{}

pub fn (mut c CLI) resize_terminal(mut socket net.TcpConn, r int, col int) {
	socket.write_string("\033[8;${r};${col}t") or { panic("[x] Error, Unable to write to socket")}
}

pub fn (mut c CLI) set_title(mut socket net.TcpConn, msg string) {
	socket.write_string("\033]0;${msg}\007") or { panic("[x] Error, Unable to write to socket") }
}