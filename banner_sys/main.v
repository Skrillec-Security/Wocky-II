module banner_sys

import os

pub struct Banner {
	pub mut:
		file string
		current_banner string
}

pub fn (mut a Banner) read_file() string {
	mut c_dir := os.getwd()
	mut fd = read_lines(c_dir + '/banner/${a.file}.txt') or {
		panic("[x] Error, Couldn't read BANNER from file!\r\n")
	}
	// convert []string to string with 'fd'
	for line in fd {
		a.current_banner += line + "\n"
	}

	//Color the banner before returning
	return new_str
}

pub fn (mut a Banner) color_banner() string {
	mut g = ''
	g = (a.current_banner).replace("{RED}", "")
	g = (a.current_banner).replace("{PURPLE}", "")
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	g = (a.current_banner).replace()
	return g
}