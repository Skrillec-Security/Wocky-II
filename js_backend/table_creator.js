var fs = require('fs');

function t_test(Username, IP, Password, Level, Maxtime, Conn, OnGoing, Admin, Expiry) {
    this.Username = Username
    this.IP = IP
    this.Password = Password
    this.Level = Level
    this.Maxtime = Maxtime
    this.Conn = Conn
    this.OnGoing = OnGoing
    this.Admin = Admin
    this.Expiry = Expiry
}

var skid = fs.readFileSync('users.db', "utf8").split("\n");
var fag = []
skid.forEach(e => {
    if(e.length > 5) {
        let lol = ((e.split("('").join("")).split("')").join("")).split("','")
        fag.push(new t_test(lol[0], lol[1], lol[2], lol[3], lol[4], lol[5], lol[6], lol[7], lol[8].split("\r").join("")))
    }
})
console.table(fag)