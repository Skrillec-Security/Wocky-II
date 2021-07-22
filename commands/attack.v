module attackcmd

pub struct AttackInfo {
	pub mut:
		ip string
		port int
		time int
		method string
}

pub fn (mut info AttackInfo) attack() string {
	
}

