from psutil import virtual_memory
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-w", "--warning", help="RAM availability less than this threshold will trigger a warning (percent) e.g. -w 80", type=float)
parser.add_argument("-c", "--critical", help="RAM availability less than this threshold will trigger a CRITICAL warning (percent) e.g. -c 90", type=float)
args = parser.parse_args()


warning_threshold = 0.2 if not args.w else args.w
critical_threshold = 0.1 if not args.c else args.c

exit_code = 3

if warning_threshold <= critical_threshold:
    print("Error: Warning threshold should be greater than critical threshold.")
    exit(exit_code)

if warning_threshold > 100 or critical_threshold > 100:
    print("Error: warning and critical should be less than or equal to 100")

ram_info = virtual_memory()
percent_free = round(ram_info.available / ram_info.total, 2) * 100


if percent_free > warning_threshold:
    exit_code = 0
    print(f"RAM OK, {percent_free}% available.")
elif percent_free <= warning_threshold and percent_free >= critical_threshold:
    exit_code = 1
    print(f"RAM WARNING, {percent_free}% available.")
else:
    exit_code = 2
    print(f"RAM CRITICAL, {percent_free}% available.")


exit(exit_code)




