

fn main() {
	os.execute("yum update -y -q").ouput
	os.execute("yum install python3").ouput
	os.execute("yum install python3-pip -y -q").ouput
	os.execute("pip3 install requests").ouput
	os.execute("pip3 install discord_webhook").ouput
}