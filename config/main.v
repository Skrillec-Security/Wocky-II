module config

pub struct Config {
	pub mut:
		cmd string
		fullcmd string
		arg []string
		arg_count int
}

pub const (
	title = "Wocky-II"
	version = "2.0.0"
)

pub const (
	Red = "\x1b[31m"
	Yellow = "\x1b[33m"
	Blue = "\x1b[34m"
	Purple = "\x1b[35m"
	Green = "\x1b[32m"
	Cyan = "\x1b[36m"
	Black = "\x1b[30m"
	Grey = "\x1b[37m"
	White = "\x1b[37m"
	Reset = "\x1b[39m"
	Background_Black = "\x1b[40m"
	Background_Red = "\x1b[41m"
	Background_Green = "\x1b[42m"
	Background_Yellow = "\x1b[43m"
	Background_Blue = "\x1b[44m"
	Background_Purple = "\x1b[45m"
	Background_Cyan = "\x1b[46m"
	Background_LightGrey = "\x1b[47m"
	Background_DarkGrey = "\x1b[100m"
	Background_LightRed = "\x1b[101m"
	Background_LightGreen = "\x1b[102m"
	Background_LightYellow = "\x1b[103m"
	Background_Reset = "\x1b[49m"
	Clear = "\033[2J\033[1;1H"
    Hostname = "\r\x1b[37m╔═[\x1b[33mWocky\x1b[37m@\x1b[33mII\x1b[37m]\r\n╚════➢\x1b[32m "
)

pub fn (mut c Config) set_config_info(cmd string, fullcmd string, arg []string, arg_c int) {
	c.cmd = cmd
	c.fullcmd = fullcmd
	c.arg = arg
	c.arg_count = arg_c
}