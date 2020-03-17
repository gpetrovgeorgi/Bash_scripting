#!/bin/bash
# This script checks each user home dir size and notifies by email (mailx for RedHat/CentOS)
# If the relevant home dir is above 500M or any other given number limit.

check_size=10
home_dir="/home/"
host=$(hostname)
ls_dir=$(ls $home_dir)

for i in $ls_dir; do
  dir_size=$(sudo du -sm ${home_dir}${i} | awk {'print $1'})  # The output value is converted in M

  if [ "$dir_size" -ge "$check_size" ]; then
    echo "User $i must do some home dir clean up. Sending him an email..."
    mail -s "Clean up needed" $i@$host <<< "You are receiving this because your home dir on host $host is around or above ${check_size}M. Please do some clean up."
  else
    echo "User $i has used ${dir_size}M out of the limit: ${check_size}M."
  fi
done

