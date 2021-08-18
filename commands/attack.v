module commands

import net
import config
import api_attack
import wocky_uix

pub fn attack_cmd(mut socket net.TcpConn, arg []string, usern string) {
	mut api_attk := api_attack.API_Attack_Info{}
	mut wuix := wocky_uix.UIX_Func{}
	mut response := api_attk.send_attack(usern, arg[1], arg[2].int(), arg[3].int(), arg[4])
	if response.len > 57 {
		for i in 0..57 {
			println(response[i])
		}
	}
	wuix.sock_place_text(mut socket, 5, 29, "►")
}