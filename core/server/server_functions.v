module server

import os
import net
import wocky_uix

pub struct ServerUtils{}
pub struct Sessions {
	pub mut:
		user []string
		clients []net.TcpConn
}

pub fn (mut su ServerUtils) list_active_user(mut socket net.TcpConn, mut p Sessions) {
	mut wuix := wocky_uix.UIX_Func{}
	mut row := 5
	mut s := 0
	for mut i in p.clients {
		wuix.sock_place_text(mut socket, row, 89, "►" + p.user[s])
		wuix.sock_place_text(mut i, row, 89, "►" + p.user[s])
		row += 1
		s += 1
	}
}