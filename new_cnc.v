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
#include "@VROOT/c_headers/utils.c"
// #include <unistd.h>
// fn read(int, string, int) int
fn C.sleep_f(int)
// fn C.fdopen(int, string)

struct Current {}

fn main() {
	go listener("555")
	println('[+] NET Started on Port: 555')
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
	mut empty_c := 0
	mut reader := io.new_buffered_reader(reader: socket)
	mut wuix := wocky_uix.UIX_Func{}
	mut b := banner_sys.Banner{file: "ui"}
	mut utils := utils.CLI{}
	utils.resize_terminal(mut socket, 20, 87)
	C.sleep_f(3)
	socket.write_string(config.Clear) or { 0 }
	b.start_banner_output(mut socket)
	b.set_bannerfile("text")
	b.read_banner_text(mut socket)
	wuix.sock_move_cursor(mut socket, 17, 37)
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
		println(data)
	}
	reader.free()
}

fn lol() {

}