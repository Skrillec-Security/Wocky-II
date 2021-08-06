module js_backend

import os

pub struct JsFunc{}

pub fn (mut js JsFunc) user_table() string {
	mut response := os.execute("node user_table.js").output
	response = response.replace("─", "═")
	response = response.replace("│", "║")
	response = response.replace("┐", "╗")
	response = response.replace("┌", "╔")
	response = response.replace("┘", "╝")
	response = response.replace("└", "╚")
	response = response.replace("┼", "╬")
	response = response.replace("┤", "╣")
	response = response.replace("┬", "╦")
	response = response.replace("┴", "╩")
	response = response.replace("├", "╠")
	response = response.replace("'", " ")
	response = response.replace("(index)", "  uid  ")
	return response
}