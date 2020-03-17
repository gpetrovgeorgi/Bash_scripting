#!/bin/bash
# This script searches for users who have not been logged in here since 90 days
# Or users who never been logged in here.

search_for="testuser"
nologin=$(lastlog -b 90 | awk {'print $1'} | grep $search_for)

func_remove_usr () {
  for i in "${@}"; do
    echo "This user has never been logged in or his log in is older than 90 days: $i"
    echo "Should be deleted ? (Y/n):"
    read ans
    if [ "$ans" == "Y" ] || [ "$ans" == "y" ]; then
      echo "Deleting user $i and his home dir with the mail spool!"
      sudo userdel -r $i
    elif [ "$ans" == "N" ] || [ "$ans" == "n" ]; then
      echo "The user $i won\`t be deleted, please notify him for further clarification of his account on this host. Thank you."
    else
      echo "You have given an invalid answer, please try again."
    fi
  done
}

func_remove_usr $nologin

echo "Do you want to create another couple of test users ? (Y/n):"
read answer
if [ "$answer" == "Y" ] || [ "$answer" == "y" ]; then
  echo "How much test user accounts would you like to create ?:"
  read nmbr
  t=1; while [ $t -le $nmbr ]; do sudo useradd testuser$t; t=`expr $t + 1`; done
elif [ "$answer" == "N" ] || [ "$answer" == "n" ]; then
  echo "Ok, will not create new user accounts for now. Goodbye."
else
  echo "You have given an invalid answer, please try again."
fi
