module commands

import net
import config
import api_attack
import wocky_uix
import wocky_utils

pub fn attack_cmd(mut socket net.TcpConn, arg []string, usern string) {
	mut api_attk := api_attack.API_Attack_Info{}
	mut wuix := wocky_uix.UIX_Func{}
	mut wutils := wocky_utils.Custom_utils{}
	mut response := api_attk.send_attack(usern, arg[1], arg[2].int(), arg[3].int(), arg[4])
	println(response)
	response = wutils.input_text_at_position(response, 55, "\r\n")
	mut lines := response.split("\n")
	wuix.sock_place_text(mut socket, 5, 29, "► ${lines[0]}")
	wuix.sock_place_text(mut socket, 6, 29, "${lines[1]}")
	mut new := wutils.input_text_at_position(lines[2], 55, "\r\n").split("\n")
	mut test := new[0]
	wuix.sock_place_text(mut socket, 6, 29, "► ${test[1]}")
	wuix.sock_place_text(mut socket, 6, 29, "► ${test[2]}")

}

pub fn output_attack_response(mut socket net.TcpConn, msg string) {
	
}