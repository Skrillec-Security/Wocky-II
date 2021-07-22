module api_attack

pub struct API_Attack_Info {
	pub mut:
		ip string
		port int
		time int
		method string
}

pub fn (mut s API_Attack_Info) send_attack() string {
	
}