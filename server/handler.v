module server

import net 

pub struct Clients {
	id int
mut:
	conn net.TcpConn
}

pub struct ServerAssets {
	clients []Clients
}

pub fn cmd_handler(mut socket net.TcpConn) {
	socket.wait_for_read() or { panic("[x] Failed") }
	data := socket.read_line().replace("\r\n", "")
	if data.len != 0 {
		if data == "test" { 
			socket.write_str("working\r\n") or { panic("[x] Error") }
			println("working")
		}
		socket.write_string("\r\x1b[37m╔═[\x1b[35mWocky\x1b[37m@\x1b[35mII\x1b[37m]\r\n╚════➢\x1b[32m ") or { panic("[x]") }
	}
	println(data)
}