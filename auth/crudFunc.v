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
	mut usr_info := s.userline()
	if usr_info.contains("[x]") {
		return 0
	}

	if s.lvl > 0 {
		return s.lvl
	} else if s.lvl < 6 {
		return s.lvl
	} else if s.lvl == 6 {
		return s.lvl
	} else {
		return 0
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

// pub fn (mut cf CrudFunc) is_