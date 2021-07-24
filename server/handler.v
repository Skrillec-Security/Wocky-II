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

pub struct Test{
	pub mut:
		lul []ServerAssets
}

pub fn cmd_handler(mut socket net.TcpConn, data string) {
	mut wocky := config.WockyInfo{creator: "vZy", version: "2.0.0"}
	if data.len == 0 {
		socket.write_string(config.Hostname) or { 0 }
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
		} else if data == "clear" or data == "cls" {
			socket.write_string(config.Clear) or { panic("[x] Error") }
		} else if data == "geo" {

		}
		socket.write_str(config.Hostname) or { 0 }
	}
	println(data)
}