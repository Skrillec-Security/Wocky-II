module utils

import os
pub struct Wocky_Settings{}

pub fn (mut w_s Wocky_Settings) get_settings() []string {
	mut settingz := os.read_lines(os.getwd() + "/config/settings.cfg") or { panic("[x] Error, Unable to read settings\r\nYou need the file with the correct setting info in it to run this net!") }
	mut info := []string
	info << settingz[0].replace("terminal_size=", "")
	info << settingz[1].replace("terminal_title=", "")
	info << settingz[2].replace("Wocky_MOTD=", "")
	info << settingz[4].replace("net_port=", "")
	info << settingz[5].replace("hostname_position=", "")
	return info
}