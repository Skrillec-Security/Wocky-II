module banner_sys

import os

pub struct MethodsBanner{
	pub mut:
		banner_c int
		banners []string
		file_name string

}

pub fn (mut mb MethodsBanner) find_banners() int {
	mut files := os.ls(os.getwd() + "/") or { panic("[x]") }
	mut found_files := []string
	for i in files {
		if i.contains(".txt") {
			found_files << i.replace(".txt", "")
		}
	}
	mb.banner_c = found_files.len
	mb.banners = found_files
	return mb.banner_c
}

pub fn (mut mb MethodsBanner) output_banner() MethodsBanner {
	return mb
}