module banner_sys

import os
import net
import config
import wocky_utils
import wocky_uix

pub struct Banner {
	pub mut:
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

pub fn (mut a Banner) color_banner() string {
	mut g := a.read_file()
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
	return g
}

pub fn (mut b Banner) start_output(mut socket net.TcpConn) {
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

	socket.write_string(main_ui.replace("╝\n", "╝")) or { 0 }
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
			// uix.sock_place_text(mut socket, r, c, output)
			uix.sock_place_text(mut socket, r.int(), c.int(), output.replace("\r\n", ""))
		}
	}
}
