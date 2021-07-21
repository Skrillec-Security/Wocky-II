module utils

pub struct LoggerUtils {
	pub mut:
		current_usr string
		log_type int // 0 = normal logs | 1 = attacks | 2 = login
		log_msg string
}

pub fn (mut u LoggerUtils) change_logType(logtype int) {
	u.log_type = logtype 
}

pub fn (mut u LoggerUtils) main(logmsg string) {
	mut logtype := match u.log_type {
		0 { "Command"}
		1 { "Attack" }
		2 { "Login" }
		else { none }
	}

	mut logthis := "[Log Type]: $logtype | ["
}

pub fn (mut u LoggerUtils) log_cmd(logmsg string) {
	mut file_d = os.open('/root/Wocky/db/logs/cmds.db') or {
		panic("[x] Error, Couldn't read CMD LOGs database!\r\n")
	}

	file_d.write("$logmsg".bytes())
	file_d.close()
}