import os

fn main() {
	mut fdrs := os.ls(os.getwd() + "/") or { panic("[x] Error, Unable to get list of files/folders") }

	for filep in filepath_1 {
		println(filep + " | " + (os.exists(filep)).str())
	}
}