import banner_sys

import os
fn main() {
	lul := (os.args).clone()
	if lul.len != 3 {
		println("[x] Error, Invalid Arugment\r\nUsage: ${lul[0]} <width> <rows>")
		exit(0)
	}
	mut b := banner_sys.Box{width: lul[1].int(), rows: lul[2].int()}
	b.create_box()
}