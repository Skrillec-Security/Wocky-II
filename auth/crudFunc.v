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

