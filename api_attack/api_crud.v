module api_attack

pub struct API_Crud {
	pub mut:
		api_name string
		api_url string
		api_methods string
		api_funnels string
}

pub fn (mut a API_Crud) api_line(apiname string) string, string, string, string, string {
	mut file_d := os.read_lines('/root/Wocky/db/apis.db') or {
		panic("[x] Error, Unable to read API database!\r\n")
	}
	mut line_c = 0
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
	return "[x] Error, Unable to find the API in database!\r\n"
}

pub fn (mut a API_Crud) add_api(apiname string) string {
	
}