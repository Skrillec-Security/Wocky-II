module utils

import os

pub struct Utils { }
pub struct Settings { }

pub fn (mut u Utils) current_time() string {
	return os.execute(r'date +"%m/%d/%y-%I:%M %p"').output
}

pub fn (mut s Settings) read_settings() {
	mut setting_list := os.read_lines(os.getwd() + "/settings.cfg") or { panic("[x] Error, Unable to read settings for Wocky!") }
	for line in setting_list {
		// match line {
		// 	ontains("[x]") {
				
		// 	}
		// }
	}
}

// pub fn (mut s Settings) 