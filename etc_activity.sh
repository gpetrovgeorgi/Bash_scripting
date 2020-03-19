#!/bin/bash
# Log all accesses to the files in /etc during the course of a single day
# If any alterations to the files take place, that will be flagged
# Write this data as tabular (tab-separated) formatted records in a logfile.

func_etc_access () {

 todays_date=$(date +'%b %d')                                  
 today_grep=$(grep "$todays_date.*sudo.*/etc" /var/log/secure)
 today_check=$(grep "$todays_date.*sudo.*/etc" /var/log/secure | wc -l)
 today_modifics=$(grep "$todays_date.*sudo.*/etc" /var/log/secure | grep 'vim\|nano\|touch' | wc -l)
 log_file=$(grep "$todays_date.*sudo.*/etc" /var/log/secure | awk {'print $15,$6,$1,$2'})
 log_file_name="/tmp/logfile_etc_$(date +'%Y-%m-%d')"
  
  if [ $today_check -gt 0 ]; then
    echo "Today we have $today_check activities related to /etc"
    if [ $today_modifics -gt 0 ]; then
      echo "From those $today_check activities, $today_modifics are related to file modifications"
    fi
  fi
  echo "Starting to extract and modify those logs..."
  echo "Those are all of the /etc related activities for $todays_date:" >> $log_file_name
  echo "==============================================================" >> $log_file_name

  for i in "${log_file}"; do  
    echo -e "$i\n" >> $log_file_name
  done

  echo "Logging activities is done. Please check: $log_file_name"
}

func_etc_access
