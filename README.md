# Nagios Check Memory

## Summary

A simple utility to check the memory usage on a server
and report back to nagios via NRPE. By default, available ram of 
less than 20% will trigger a warning and less than 10% is 
critical, but this can be configured using the --warning and 
--critical options.

## Installation

**You should have the NRPE plugin installed on your host before you try this**

This script should be installed on the host that you'd like to monitor.

Clone the repo to somewhere on your host and then run the install.sh script (you may need to sudo this or run it as root)

This will create a check_memory directory containing a virtual enviroment, check_ram.py, and check_ram.sh to run check_ram.py
using that enviroment in /usr/lib/nagios/plugins, and then create a symlink to check_ram.sh in /usr/lib/nagios/plugins.

You'll then need to define a command in your /etc/nagios/nrpe/nrpe.cfg file, for example:


`command\[check_memory\]=/usr/lib/nagios/plugins/check_memory.sh`


From there, you can use this command in a service definition on your nagios server. 

