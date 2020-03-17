#!/bin/bash
# Deletes files older than 1 minute in ~/trash dir
# It makes back up of given file names as argument/s to this script in tar.gz format within the ~/trash dir

bcdir="/home/cloud_user/trash/"
find_count=$(find $bcdir -type f -cmin +1 | wc -l)
clear

if [ ! -d $bcdir ]; then
  mkdir $bcdir
fi

echo -e "Checking & cleaning older files in $bcdir...\n"
if [ $find_count -gt 0 ]; then
  echo "There are: $find_count older files in $bcdir. Deleting them (="
  find $bcdir -type f -cmin +1 | xargs rm
else
  echo "There are no older files in $bcdir"
fi

echo "Starting to back up those: $@"

for i in "${@}"; do
  tar -czf ${bcdir}${i}.tar.gz $i
done

