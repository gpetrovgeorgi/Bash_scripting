#!/bin/bash
# Parse /var/log/messages to produce a nicely formatted file of user logins and login times.

echo "Enter a username for which you want to be created a logins log file:"
read username
logfile_name="$(date +'%Y-%m-%d').${username}.login.log"

sudo grep -i login /var/log/messages | grep -i 'new session' | grep $username > $logfile_name

echo "Logfile is created. It\`s name is $logfile_name"

echo "Do you need to check further the file ? (Y/n):"
read ans

if [ "$ans" == "Y" ] || [ "$ans" == "y" ]; then
  echo "The file will be kept on your disposal."
elif [ "$ans" == "N" ] || [ "$ans" == "n" ]; then
  echo "The file will be deleted upon ending of the script !"
  rm -rf $logfile_name
else
  echo "You entered an invalid answer. Please try again."
fi

exit 0
