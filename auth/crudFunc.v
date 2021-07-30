module auth

pub struct CrudFunc {
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
pub fn (mut cf CrudFunc) is_premium() bool {
	mut s := Crud{user: cf.user}
	mut usr_info := s.userline()
	if usr_info.contains("[x]") {
		return false
	}

	if s.lvl in [1,2,3,4,5,6] {
		return true
	} else {
		return false
	}
}

// method -> is_admin() int 
// note -> check if the user is admin!
//         upto 3 ranks (0 = no admin | 1 = reseller | 2 = admin | 3 = owner)
pub fn (mut cf CrudFunc) is_admin() int {
	mut s := Crud{user: cf.user}
	mut usr_info := s.userline()
	if usr_info.contains("[x]") {
		return 0
	}

	if s.admin > 0 {
		return s.admin
	} else if s.admin <= 3 {
		return s.admin
	} else {
		return 0
	}
}