module utils

import net

pub struct CLI{}

pub fn (mut c CLI) resize_terminal(mut socket net.TcpConn, r int, col int) {
	socket.write_string("\033[8;${r};${col}t") or { 0 }
}

pub fn (mut c CLI) set_title(mut socket net.TcpConn, msg string) {
	socket.write_string("\033]0;${msg}\007") or { 0 }
}

pub fn (mut c CLI) move_cursor_up_once(mut socket net.TcpConn) {
	socket.write_string("\033[1A") or { 0 }
}

pub fn (mut c CLI) move_cursor_up(mut socket net.TcpConn, count int) {
	socket.write_string("\033[${count}A") or { 0 }
}