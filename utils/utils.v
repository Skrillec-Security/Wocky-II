module utils

import os

pub struct Utils { }

pub fn (mut u Utils) current_time() string {
	return os.execute(r'date +"%m/%d/%y-%I:%M %p"').output
}