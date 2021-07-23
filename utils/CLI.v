module utils

import net

pub struct CLI{}

pub fn (mut c CLI) resize_terminal(mut socket net.TcpConn, r int, col int) {
	socket.write_string("\033[8;${r};${col}t") or { panic("[x] Error, Unable to write to socket")}
}