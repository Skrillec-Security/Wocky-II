module banner_sys

import os
import net
import config
import wocky_utils
import wocky_uix
import utils
import auth

#include "@VROOT/c_headers/utils.c"

fn C.sleep_f(int)

pub struct Banner {
	pub mut:
		username string
		ip string
		lvl int
		mtime int
		conn int
		ongoing int
		admin int
		expiry string
		file string
		current_banner string
}

pub fn (mut a Banner) set_bannerfile(filepath string) {
	a.file = filepath
}

pub fn (mut a Banner) read_file() string {
	mut c_dir := os.getwd()
	mut fd := os.read_lines(c_dir + '/banners/${a.file}.txt') or {
		panic("[x] Error, Couldn't read BANNER from file!\r\n")
	}
	mut new_str := ''
	// convert []string to string with 'fd'
	for line in fd {
		a.current_banner += line + "\n"
		new_str += line + "\n"
	}

	//Color the banner before returning
	return new_str
}

pub fn (mut a Banner) set_username(username string) {
	a.username = username
}

pub fn (mut a Banner) color_banner() string {
	mut g := a.read_file()
	g = a.replace_code(g)
	return g
}

pub fn (mut b Banner) replace_code(lul string) string {
	mut g := lul
	mut ns := utils.Net_Stats{}
	mut user_info := []string
	if b.username != "" {
		mut crud := auth.Crud{user: b.username}
		user_info = crud.userline().split(",")
		b.ip = user_info[1]
		b.lvl = user_info[3].int()
		b.mtime = user_info[4].int()
		b.conn = user_info[5].int()
		b.ongoing = user_info[6].int()
		b.admin = user_info[7].int()
		b.expiry = user_info[8]
	}
	g = g.replace("\n", "\r\n")
	g = g.replace("{RED}", config.Red)
	g = g.replace("{YELLOW}", config.Yellow)
	g = g.replace("{BLUE}", config.Blue)
	g = g.replace("{PURPLE}", config.Purple)
	g = g.replace("{GREEN}", config.Green)
	g = g.replace("{BLACK}", config.Black)
	g = g.replace("{GREY}", config.Grey)
	g = g.replace("{CYAN}", config.Cyan)
	g = g.replace("{WHITE}", config.White)
	g = g.replace("{RESET}", config.Reset)
	g = g.replace("{BG_BLACK}", config.Background_Black)
	g = g.replace("{BG_RED}", config.Background_Red)
	g = g.replace("{BG_GREEN}", config.Background_Green)
	g = g.replace("{BG_YELLOW}", config.Background_Yellow)
	g = g.replace("{BG_BLUE}", config.Background_Blue)
	g = g.replace("{BG_PURPLE}", config.Background_Purple)
	g = g.replace("{BG_CYAN}", config.Background_Cyan)
	g = g.replace("{BG_LIGHTGREY}", config.Background_LightGrey)
	g = g.replace("{BG_DARKGREY}", config.Background_DarkGrey)
	g = g.replace("{BG_LIGHTRED}", config.Background_LightRed)
	g = g.replace("{BG_LIGHTGREEN}", config.Background_LightGreen)
	g = g.replace("{BG_LIGHTYELLOW}", config.Background_LightYellow)
	g = g.replace("{BG_RESET}", config.Background_Reset)
	g = g.replace("{USERNAME}", b.username)
	g = g.replace("{IP}", b.ip)
	g = g.replace("{LEVEL}", (b.lvl).str())
	g = g.replace("{MAXTIME}", (b.mtime).str())
	g = g.replace("{CONCURRENTS}", (b.conn).str())
	g = g.replace("{ONGOING}", (b.ongoing).str())
	g = g.replace("{ADMIN}", (b.admin).str())
	g = g.replace("{EXPIRY}", b.expiry)
	g = g.replace("{TOTALUSERS}", ns.total_users().str())
	g = g.replace("{TOTALATTACKS}", ns.total_attacks().str())
	g = g.replace("{TOTALAPIS}", ns.total_apis().str())
	return g
}

pub fn (mut b Banner) start_banner_output(mut socket net.TcpConn) {
	// Declarations
	mut str_utils := wocky_utils.Custom_utils{}
	mut uix := wocky_uix.UIX_Func{}
	mut main_ui := ""
	lines := b.color_banner().split("\n")
	for line in lines {
		if line.contains("place_text") {
		} else {
			main_ui += "${line}\r\n"
		}
	}
	socket.write_string(main_ui.trim_space()) or { 0 }
}

pub fn (mut b Banner) read_banner_text(mut socket net.TcpConn) {
	// Declarations
	mut str_utils := wocky_utils.Custom_utils{}
	mut uix := wocky_uix.UIX_Func{}
	mut lines := b.color_banner().split("\n")
	for line in lines {
		if line.contains("place_text(") {
			output := line.split("=")[1]
			mut r, c := str_utils.get_str_between(line, "(", ")")
			uix.sock_place_text(mut socket, r.int(), c.int(), b.replace_code(output))
		}
	}
}

pub fn (mut b Banner) clear_screen(mut socket net.TcpConn) {
	mut wuix := wocky_uix.UIX_Func{}
	wuix.sock_place_text(mut socket, 3, 27, "${config.White}╠═══════════════════════════════════════════════════════════╣")
	for i in 5..19 {
		wuix.sock_place_text(mut socket, i, 27, "${config.White}║                                                           ║")
	}
	wuix.sock_place_text(mut socket, 19, 27, "${config.White}╠═══════════════════════════════════════════════════════════╣")
	wuix.sock_move_cursor(mut socket, 21, 36)
	socket.write_string("                                      ") or { 0 }
}

pub fn (mut b Banner) loading_screen(mut socket net.TcpConn) {
	socket.write_string(config.Clear) or { 0 }
	mut wuix := wocky_uix.UIX_Func{}
	b.set_bannerfile("logo")
	socket.write_string(b.color_banner()) or { 0 }
	wuix.sock_place_text(mut socket, 9, 50, config.Yellow + "[ Loading .... ]")
	wuix.sock_move_cursor(mut socket, 10, 51)
	mut s := 5
	for i in 0..7 {
		socket.write_string("##") or { 0 }
		C.sleep_f(1)
	}
	wuix.sock_move_cursor(mut socket, 9, 66)
	socket.write_string(config.Clear) or { 0 }
}