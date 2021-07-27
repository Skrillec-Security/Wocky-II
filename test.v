import api_attack

import os

fn main() {
	mut f := api_attack.API_Crud{}
	mut skid := f.apis_with_method("LDAP")
	println(skid)
}