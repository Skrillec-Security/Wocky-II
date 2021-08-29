module banner_sys

// Mode for data type usage
// 1 = line
// 2 = lines
pub struct Box{
	pub mut:
		box string
		width int
		rows int
		lines []string
		line string
		mode int
}

pub struct Table{
	pub mut:
		table string
		rows int
		column int
		//Lines u want to add
		lines []string
		line string
		mode int
}

const (
	left_top_corner = "╔"
	right_top_corner = "╗"
	left_bottom_corner = "╚"
	right_bottom_corner = "╝"

	horizontal_line = "═"
	horizontal_down = "╦"
	horizontal_up = "╩"

	vertical_line = "║"
	vertical_left = "╣"
	vertical_right = "╠"
	
	cross = "╬"
)

pub fn (mut b Box) set_box_size(box_width int, box_rows int) {
	b.width = box_width
	b.rows = box_rows
}

pub fn (mut b Box) set_mode(m int) {
	b.mode = m
}

pub fn (mut b Box) create_box() {
	//Create the top line
	mut first_line := left_top_corner
	for i in 0..(b.width) {
		if i > 1 {
			first_line += horizontal_line
		}
	}
	first_line += right_top_corner

	// Creating rows
	mut boxx := ""
	for i in 0..(b.rows) {
		boxx += vertical_line
		for s in 0..(b.width) {
			if s > 1 {
				boxx += " "
			}
		}
		boxx += "${vertical_line}\r\n"
	}
	boxx = boxx.trim_space()
	

	//Create last line
	mut last_line := left_bottom_corner
	for i in 0..(b.width) {
		if i > 1 {
			last_line += horizontal_line
		}
	}
	last_line += right_bottom_corner

	println("${first_line}\r\n${boxx}\r\n${last_line}")
}



pub fn (mut b Box) append_arr(lines []string) {

}

pub fn (mut b Box) append_ln(line string) {

}