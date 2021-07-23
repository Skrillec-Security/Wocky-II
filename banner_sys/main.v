module banner_sys

import os

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
	mut g := ''
	g = (a.current_banner).replace("{RED}", "")
	g = (a.current_banner).replace("{PURPLE}", "")
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	// g = (a.current_banner).replace()
	return g
}