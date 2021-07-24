module auth

struct CrudFunc {
	pub mut:
		user string
		ip string
		pw string
		lvl int
		mtime int
		conn int
		ongoing int
		expiry string
}

// method -> is_premium() int
// note -> checks if a user is premium! 
//         upto 6 ranks! ( this can be changed for more ranks)
//         the max rank might be live updatable
pub fn (mut cf CrudFunc) is_premium() int {
	mut s := Crud{user: cf.user}
	mut usr_info := s.read_line()
	if usr_info.contains("[x]") {
		return usr_info
	}

	usr_info = usr_info.split(",")

	if usr_info[3].int() > 0 or usr_info[3].int() <= 6 {
		return usr_info
	} else {
		return 0
	}

}

// method -> is_admin() int 
// note -> check if the user is admin!
//         upto 3 ranks (0 = no admin | 1 = reseller | 2 = admin | 3 = owner)
pub fn (mut cf CrudFunc) is_admin() int {

}