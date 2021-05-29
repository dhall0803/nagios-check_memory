from typing import Match
from psutil import virtual_memory

warning_threshold = 0.2
critical_threshold = 0.1
exit_code = 3
ram_info = virtual_memory()
percent_free = round(ram_info.available / ram_info.total, 2)
message = ""

if percent_free > warning_threshold:
    exit_code = 0
    message = f"RAM OK, {percent_free}% available."
elif percent_free <= warning_threshold and percent_free >= critical_threshold:
    exit_code = 1
    message = f"RAM WARNING, {percent_free}% available."
else:
    exit_code = 2
    message = f"RAM CRITICAL, {percent_free}% available."


print(message)
exit(exit_code)


