module commands

import net
import net.http

pub fn geo_cmd(mut socket net.TcpConn, data string) {
	mut arg := data.split(" ")
	if arg.len == 1 {
		mut geo := http.get_text("http://ip-api.com/json/${arg[1]}")
		geo = ((geo.replace(",", "\r\n")).replace('"', "")).replace(":", "   :   ")
		socket.write_string(geo) or { 0 }
	} else {
		socket.write_string("[x] Error, Invalid argument\r\nUsage: geo <ip>\r\n") or { 0 }
	}
}