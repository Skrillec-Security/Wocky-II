module wocky_uix

import os
import net

pub struct UIX_Func {
	pub mut:
		last_row string
		last_column string
		text string
}
pub fn (mut uix UIX_Func) sock_change_size(mut socket net.TcpConn, r int, c int) {
	socket.write_string("\033[8;${r};${c}t") or { 0 }
}

pub fn (mut uix UIX_Func) sock_place_text(mut socket net.TcpConn, r int, c int, msg string) {
	socket.write_string("\033[${r};${c}f${msg}") or { 0 }
}

pub fn (mut uix UIX_Func) sock_move_cursor(mut socket net.TcpConn, r int, c int) {
	socket.write_string("\033[${r};${c}f") or { 0 }
}