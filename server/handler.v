module server

import net
import banner_sys
import config 


pub struct ServerAssets {
	pub mut:
		empty_c int
		cnc_port string
		clients []net.TcpConn
}

pub fn cmd_handler(mut socket net.TcpConn, data string) {
	mut wocky := config.WockyInfo{creator: "vZy", version: "2.0.0"}
	if data.len == 0 {
		socket.write_string("\r\x1b[37m╔═[\x1b[35mWocky\x1b[37m@\x1b[35mII\x1b[37m]\r\n╚════➢\x1b[32m ") or { panic("[x] Error, Failed to send hostname to socket!\r\n") }
	} else {
		mut c := config.Config{}
		mut b := banner_sys.Banner{}
		if data.contains(" ") {
			c.set_config_info((data.split(" ")[0]), data, (data.split(" ")), ((data.split(" ")).len))
		} else { c.set_config_info(data, data, [data], data.len) }

		// Command Handling
		if data == "help" {
			b.set_bannerfile('help')
			socket.write_string(b.read_file()) or { panic("[x] Error") }
		} else if data == "geo" {

		}
		socket.write_string("\r\x1b[37m╔═[\x1b[35mWocky\x1b[37m@\x1b[35mII\x1b[37m]\r\n╚════➢\x1b[32m ") or { panic("[x] Error, Failed to send hostname to socket!\r\n") }
	}
	println(data)
}