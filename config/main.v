module config

pub struct Config {
	pub mut:
		cmd string
		fullcmd string
		arg []string
		arg_count int
}

pub struct WockyInfo {
	pub mut: 
		creator string
		version string
}

pub const (
    Red = "\x1b[34m"
    Yellow = "\x1b[97m"
    Blue = "\x1b[34m"
    Purple = "\x1b[95m"
    Green = "\x1b[32m"
    Cyan = "\x1b[96m"
    Black = "\x1b[30m"
    Grey = "\x1b[90m"
    White = "\x1b[97m"
    Reset = "\x1b[39m"
    Background_Red = "\x1b[41m"
    Background_Green = "\x1b[42m"
    Background_Grey = "\x1b[100m"
    Background_Reset = "\x1b[49m"
    Clear = "\033[2J\033[1;1H"
)

pub fn (mut c Config) set_config_info(cmd string, fullcmd string, arg []string, arg_c int) {
	c.cmd = cmd
	c.fullcmd = fullcmd
	c.arg = arg
	c.arg_count = arg_c
}