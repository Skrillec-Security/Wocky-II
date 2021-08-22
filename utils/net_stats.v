module utils

import os

pub struct Net_Stats{}

pub fn (mut ns Net_Stats) total_users() int {
	mut users := os.read_lines(os.getwd() + "/db/users.db") or { ["", ""] }
	return users.len
}

pub fn (mut ns Net_Stats) total_attacks() int {
	mut attacks := os.read_lines(os.getwd() + "/db/logs/attacks.db") or { ["", ""] }
	return attacks.len
}

pub fn (mut ns Net_Stats) total_apis() int {
	mut apis := os.read_lines(os.getwd() + "/db/apis.db") or { ["", ""] }
	mut api_c := 0
	for i in apis {
		if i.contains("api_Name=") {
			api_c += 1
		}
	}
	return api_c
}