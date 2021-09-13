import banner_sys
import wocky_uix

import os
fn main() {
	mut width := os.input("Box Width: ")
	mut rows := os.input("Box Rows: ")
	mut b := banner_sys.Box{width: width.int(), rows: rows.int()}
	mut wuix := wocky_uix.UIX_Func{}
	
	mut test := b.create_box()
	println("\033[2J\033[1;1H$test")
	mut new_c := 1 
	for i in 0..(rows.int()) {
		mut input_data := os.input("TermUIX >> ")
		if input_data == "addtext" {
			mut text := os.input("Text to add to box?: ")
			mut row := os.input("What row do you want the text on?: ")
			mut column := os.input("What column do you want the text to start on that row?: ")
			test = b.append_text_in_position(test, row.int(), column.int(), text.trim_space(), new_c)
			println("\033[2J\033[1;1H$test")
		} else if input_data == "resize" {
			width = os.input("Box Width: ")
			rows = os.input("Box Rows: ")
			b.set_box_size(width.int(), rows.int())
			test = b.create_box()
			println("\033[2J\033[1;1H$test")
		} else if input_data == "addbox" {
			for {

			}
		} else {
			println("no command found")
		}
		new_c += 1
	}
}