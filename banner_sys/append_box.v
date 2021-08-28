module banner_sys

// Mode for data type usage
// 1 = line
// 2 = lines
pub struct Box{
	pub mut:
		box string
		lines []string
		line string
		mode int
}

pub fn (mut b Box) set_mode(m int) {
	b.mode = m
}

pub fn (mut b Box) append_arr(lines []string) {

}

pub fn (mut b Box) append_ln(line string) {

}