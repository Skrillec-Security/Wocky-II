module commands

import net
import config
import api_attack

pub fn attack_cmd(mut socket net.TcpConn, arg []string, usern string) {
	println('test 2')
	mut api_attk := api_attack.API_Attack_Info{}
	socket.write_string((api_attk.send_attack(usern, arg[1], arg[2].int(), arg[3].int(), arg[4]))) or { panic("[x] Error, Unable to send attack response!\r\n")}
}