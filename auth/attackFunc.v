module auth

pub struct AttackFunc {
	pub mut:
		user string
		ip string
		port int
		time int
		method string
}

pub fn (mut af AttackFunc) attack_validation() bool {
	mut c := Crud{user: af.user}
	mut info_check := c.userline()
	if info_check.contains("[x]") { return false }
	if c.conn == c.ongoing {
		return false
	} else {
		return true
	}
}

pub fn (mut af AttackFunc) validate_time() bool {
	mut c := Crud{user: af.user}
	mut info_check := c.userline()
	if info_check.contains("[x]") { return false }
	mut info := info_check.split(",")
	if c.mtime > af.time{
		return true
	} else if c.mtime == af.time {
		return true
	} else {
		return false
	}
}