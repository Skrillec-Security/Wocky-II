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
		columns int
		column_width []int
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

pub fn (mut b Box) create_box() string {
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

	return "${first_line}\r\n${boxx}\r\n${last_line}"
}

/*
 method -> append_text_in_position(box, row, column, text, num)
 note -> use 1 for 'num' argument. 
         if you use this in a loop, you must add 1 to 'num' when using the function in loop

 example:
		fn main() {
			mut box := banner_sys.Box{}
			mut box_str := box.create_box()
			mut box_w_str := box.append_text_in_position(box_str, 5, 29, "$i", 1)
		}

 example with loop:
		fn main() {
			mut box := banner_sys.Box{width: w, rows: r}
			mut box_str := box.create_box()
			mut output_line_start := 5
			for i in 0..(r.len) { 
				mut box_w_str := box.append_text_in_position(box_str, output_line_start, 29, "$i", i)
				output_line_start += 1
			}
		}
*/
pub fn (mut b Box) append_text_in_position(box string, row int, c int, input_text string, test int) string {
	mut j := box.trim_space()
	mut rows := j.split("\n")
	mut new_box := ""
	mut cnt := 0
	for i in rows {
		if cnt == row { // find the row user wants their text on 
			mut fix := i.replace("║", "")
			mut spaces := fix.len - input_text.len
			mut g := "${vertical_line} "
			for s in 0..(spaces-test) {
				println("$s")
				if s == c { // find the column user wants their text position in the row
					g += input_text // append text
				} else {
					g += " " // add spaces back in
				}
			}
			g += "${vertical_line}"
			println(g)
			new_box += g + "\r\n"
		} else {
			new_box += i + "\r\n"
		}
		cnt += 1
	}
	return new_box
}

/*
Table Creator Starts Here
*/

pub fn (mut t Table) set_mode(m int) {
	t.mode = m
}


/* 
method -> set_table_size(r, c, c_w)
	rows INT
	columns INT
	column_widths []INT

note -> the amount of elements in 'column_width' must match 'column'
*/
pub fn (mut t Table) set_table_size(r int, c int, c_w []int) { 
	t.rows = r
	t.columns = c
	t.column_width = c_w
	if c_w.len != c {
		panic("[x] Error, You must specify each column width in array for c_w argument!")
	}
}

pub fn (mut t Table) create_table() {

}