module api_attack

import os

pub struct API_Crud {
	pub mut:
		api_name string
		api_url string
		api_methods string
		api_funnels string
}

pub fn (mut a API_Crud) api_line(apiname string) (string, string, string, string, string) {
	mut file_d := os.read_lines('/root/Wocky/db/apis.db') or {
		panic("[x] Error, Unable to read API database!\r\n")
	}
	mut line_c := 0
	for api in file_d {
		if api.len > 5 {
			if api.contains("api_Name=${apiname}") {
				mut api_name := api.replace("api_Name=", "")
				mut api_url := file_d[line_c+1].replace("api_URL=", "")
				mut api_methods := file_d[line_c+2].replace("api_Methods=", "")
				mut api_access := file_d[line_c+3].replace("api_Access=", "")
				mut api_funnels := file_d[line_c+4].replace("api_Funnels=", "")
				return api_name, api_url, api_methods, api_access, api_funnels
			}
		}
		line_c += 1
	}
	return "", "", "", "", ""
}

pub fn (mut a API_Crud) apis_with_method(method string) []string {
	mut apis := os.read_lines(os.getwd() + "/db/apis.db") or {
		panic("[x] Error, Unable to read API database!\r\n")
	}
	mut i := 0
	mut test := []string
	for api in apis {
		if api.len > 5 {
			if api.contains("api_Name=${a.api_name}") {
				mut api_name := api.replace("api_Name=", "")
				mut api_url := apis[i+1].replace("api_URL=", "")
				mut api_methods := apis[i+2].replace("api_Methods=", "")
				mut api_access := apis[i+3].replace("api_Access=", "")
				mut api_funnels := apis[i+4].replace("api_Funnels=", "")
				mut methods := api_methods.split("|")
				if method in methods {
					test << api_url
				}
			}
		}
		i += 1
	}

	return test
}

pub fn (mut a API_Crud) add_api() string {
	mut f := os.open_append(os.getwd() + "/db/apis.db") or {
		panic("[x] Error, Unable to read API database!\r\n")
	}
	f.write("api_Name=${a.api_name}\napi_URL=${a.api_url}\napi_Methods=${a.api_methods}\napi_Funnels=${a.api_funnels}\n".bytes()) or { panic("[x] Error, Unable to write to API database!\r\n") }
	return "[x] API: ${a.api_name} successfully added!\r\n"
}

pub fn (mut a API_Crud) remove_api() string {
	mut apis := os.read_lines(os.getwd() + "/db/apis.db") or {
		panic("[x] Error, Unable to read API database!\r\n")
	}
	mut i := 0
	mut new_db := ''
	mut start_del := false
	for api in apis {
		if api.len > 5 {
			if api.contains("api_Name=${a.api_name}") {
				mut api_url := apis[i+1].replace("api_URL=", "")
				mut api_methods := apis[i+2].replace("api_Methods=", "")
				mut api_access := apis[i+3].replace("api_Access=", "")
				mut api_funnels := apis[i+4].replace("api_Funnels=", "")
				start_del = true
			} else if start_del == true && api.contains("api_Funnels=") {
				start_del = false
			} else {
				new_db += api + "\n"
			}
		}
		i += 1
	}

	os.write_file(os.getwd() + "/db/apis.db", new_db) or {
		panic("[x] Error, Unable to read API database!\r\n")
	}
	return "[x] API: $a.api_name successfully removed!\r\n"
}