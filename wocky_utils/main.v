module wocky_utils

pub struct Custom_utils { }

// methods -> custom_contains_for_v_match_statement(matching_value, matchthis)
// note -> this function was made to use in V's match statement since you can't use 'string.contains()'
//         in the statement
pub fn (mut c_u Custom_utils) custom_contains_for_v_match_statement(matching_value string, matchthis string) string {
	if matchthis.contains(matching_value) {
		return matchthis
	} else {
		return matching_value
	}
}

// method -> get_str_between(find_str, start, end)
// note -> this function was made bc V has alot of useful BUILT-In functions BUT THIS ONE!!!!!!!@!!!!!!
//         this is an important function instead of having to keep splitting strings!!!!!!
pub fn (mut c_u Custom_utils) get_str_between(find_str string, start string, end string) (string, string) {
		mut recording := false
		mut returning := ''
	for i in 0..(find_str.len) {
		mut c := find_str[i].ascii_str()
		if c == start {
			recording = true
		} else if c == end {
			recording = false
		} else if recording == true {
			returning += c
		}
	}
	return returning.split(",")[0], returning.split(",")[1]
}

// pub fn (mut c_u Custom_utils) remove_last_char