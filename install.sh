#!/bin/bash
set -e
#Create check_memory directory in /usr/lib/nagios/plugins
printf "Installing nagios check memory\n"

#If the check_memory directory or check_memory.sh symlink already exists (for example from a previous failed install), delete them

if [[ -d /usr/lib/nagios/plugins/check_memory ]]
then
    printf "Removing old /usr/lib/nagios/plugins/check_memory directory\n"   
    rm -r /usr/lib/nagios/plugins/check_memory
fi

if [[ -L /usr/lib/nagios/plugins/check_memory.sh ]]
then 
    printf "Removing old /usr/lib/nagios/plugins/check_memory.sh file\n" 
    rm /usr/lib/nagios/plugins/check_memory.sh
fi

printf "Copying files to plugins directory...\n"
if [[ -d /usr/lib/nagios/plugins/ ]]
then
    mkdir -p /usr/lib/nagios/plugins/check_memory
else
    printf "Directory /usr/lib/nagios/plugins/, is nrpe installed?\n Quitting...\n"
    exit 1
fi


#Copy script files to /usr/lib/nagios/plugins/check_memory

files=("./check_memory.py" "./check_memory.sh" "license.txt" "README.md" "requirements.txt")
for file in "${files[@]}"
do
    cp "$file" /usr/lib/nagios/plugins/check_memory
done

#navigate to /usr/lib/nagios/plugins/check_memory and create a virtual enviroment

cd /usr/lib/nagios/plugins/check_memory || exit

printf "Creating python virtual enviroment and installing dependencies...\n"
#You may need to change this to python -m venv .env depending on your distro - the check_memory.py requires > python 3.6 
python3 -m venv .env

#Activate virtual enviroment, update pip and install dependencies:

source ./.env/bin/activate

python -m pip install -U pip

pip install -r requirements.txt 

#Leave virtual enviroment

deactivate

#Create symlink to check_memory.sh in /usr/lib/nagios/plugins/ and make executable:
printf "Creating symlink check_memory.sh\n"
ln -s /usr/lib/nagios/plugins/check_memory/check_memory.sh /usr/lib/nagios/plugins/check_memory.sh

chmod 755 /usr/lib/nagios/plugins/check_memory.sh

printf "Install complete! You can test by running /usr/lib/nagios/plugins/check_memory.sh\n"

