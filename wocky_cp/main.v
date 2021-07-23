module wocky_cp

import os
import net.http
import banner_sys
import config

// method -> licence_validation()
// note -> licence based botnet 
pub fn licence_valiation() {
	mut wocky := config.WockyInfo{creator: "vZy", version: "2.0.0"}
	mut token := os.input("Wocky Token Key: ")
	if token == "" { println("[x] Access denied, Invalid token!") exit(0) }
	if token.len > 10 {
		mut token_check := http.get_text("http://194.147.35.227/wocky/?token=$token&version=${wocky.version}")
		if token_check.contains("[x]") {
			println("[x] Access denied, Invalid token!")
		} else if token_check.contains("[+]") {
			println("[x] Access Granted! | $token")
			println(help_banner())
		}
	} else {
		println("[x] Access denied, Invalid Token!\r\n")
		exit(0)
	}
}

// method -> conn_check()
// note -> Run this as first thing in script. Optional expection
pub fn conn_check()? {
	http.get("https://google.com") or {
		panic("[x] Error, No internet detected on the system to continue!\r\n")
	}
}

pub fn help_banner() string { 
	mut bnnr := ''
	bnnr += "Welcome To Wocky II Server Side | Coded In: V | Created By: vZy                    [v2.0.0]\r\n"
	bnnr += "        Tools              Description\r\n"
	bnnr += "_______________________________________________________________\r\n"
	bnnr += "      - users             Check online users\r\n"
	bnnr += "      - userlist          List of user on the net\r\n"
	bnnr += "      - kick              Kick a user\r\n"
	bnnr += "      - usage             Show CPU & MEM Usage of the net\r\n\r\n"
	return bnnr
}