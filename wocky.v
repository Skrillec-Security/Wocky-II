import server
import auth

import os
import io
import net
import time

const (
	port = 3000
)

fn main() {
	println("Welcome to Wocky-II Server-Side")
	go listener()
	// go test()
	println('[+] NET Started on Port: $port')
	for {
		mut input_cmd := os.input("[Wocky@CP]# [~]$ ")
		if input_cmd.len == 0 { return }
		// Continue CP from here
	}
}

// fn test() {
// 	mut i := 0
// 	for {
// 		mut t := io.Teststr{}
// 		println("$i | $t.buffer")
// 		i += 1
// 		time.sleep(2)
// 	}
// }

fn listener() {
	mut server := net.listen_tcp(.ip6, ':3000') or {
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
	mut reader := io.new_buffered_reader(reader: socket)
	mut current_ip := socket.peer_addr() or { return } //User's IP
	println('> new client: $current_ip')

	socket.write_str("Username: ") or { panic("[x] Error") }
	username := socket.read_line()
	socket_write_str("Password: ") or { panic("[x] Error") }
	password := socket.read_line()
	
	//command handler
	for {
		data := socket.read_line()
		server.cmd_handler(mut socket, data)
	}
	
	reader.free()
}

fn command_handler(mut socket net.TcpConn) {

}
