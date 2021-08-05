import os

fn main() {
	mut response := os.execute("node test.js").output
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
	println(response)
}