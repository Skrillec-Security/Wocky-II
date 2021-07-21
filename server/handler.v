module server

import net 

pub fn cmd_handler(mut socket net.TcpConn, data string) {
	if data == "test" { 
		socket.write_str("working") or { break }
	}
}