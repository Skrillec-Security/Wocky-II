module commands

import net
import net.http

pub fn geo_cmd(mut socket net.TcpConn, ip string) {
	mut geo := http.get_text("http://ip-api.com/json/{query}${ip}")
	geo = ((geo.replace(",", "\r\n")).replace('"', "")).replace(":", "   :   ")
	socket.write_string(geo) or { panic("[x] Error, Unable to send geo response!") }
}