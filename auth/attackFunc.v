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
	mut info := c.userline()
	if info.contains("[x]") { return info }
	info = info.split(",")
	if info[5].int() == info[6].int() {
		return false
	} else {
		return true
	}
}

pub fn (mut af AttackFunc) validation_time() bool {
	mut c := Crud{user: af.user}
	mut info := c.userline()
	if info.contains("[x]") { return info }
	info = info.split(",")
	if info[4].int() =< af.time {
		return false
	} else {
		return true
	}
}