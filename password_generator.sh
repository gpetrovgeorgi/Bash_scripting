#!/bin/bash
# This generates passwords by given:
# Number and length of passwords

clear

echo "Please enter the password length in characters:"
read passwd_length

echo "Please enter how many passwords do you need:"
read passwd_num

echo "Do you want numbers placed within the passwords (Y/n):"
read numbers

echo "Do you want lowercase letters (Y/n):"
read lower

echo "Do you want uppercase letters (Y/n):"
read upper

if [ "$numbers" == "Y" ] || [ "$numbers" == "y" ] && [ "$lower" == "Y" ] || [ "$lower" == "y" ] && [ "$upper" == "Y" ] || [ "$upper" == "y" ]; then
  echo "Your passwords are:"
  head -c 5000 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $passwd_length | head -n $passwd_num

elif [ "$numbers" == "Y" ] || [ "$numbers" == "y" ] && [ "$lower" == "Y" ] || [ "$lower" == "y" ]; then
  echo "Your passwords are:"
  head -c 5000 /dev/urandom | tr -dc 'a-z0-9' | fold -w $passwd_length | head -n $passwd_num

elif [ "$numbers" == "Y" ] || [ "$numbers" == "y" ] && [ "$upper" == "Y" ] || [ "$upper" == "y" ]; then
  echo "Your passwords are:"
  head -c 5000 /dev/urandom | tr -dc 'A-Z0-9' | fold -w $passwd_length | head -n $passwd_num

elif [ "$lower" == "Y" ] || [ "$lower" == "y" ] && [ "$upper" == "Y" ] || [ "$upper" == "y" ]; then
  echo "Your passwords are:"
  head -c 5000 /dev/urandom | tr -dc 'a-zA-Z' | fold -w $passwd_length | head -n $passwd_num                                                   

else
  echo "Something went wrong, please check your input data and try again !"
  exit 1
fi

exit 0
