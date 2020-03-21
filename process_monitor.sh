#!/bin/bash
# This script continually monitors all running processes and to keep track of how many child processes each parent spawns. 
# If a process spawns more than five children, then the script sends an e-mail to the system administrator 
# with all relevant information, including the time, PID of the parent, PIDs of the children, etc. 
# The script appends a report to a log file.

rm -rf /tmp/pstree.info 2> /dev/null

func_psmonitor () {
  parentps=$(ps axjf | awk {'print $2'} | grep -v 'PID')
  admin="cloud_user"

  for i in $parentps; do
    ps_count=$(pgrep -P ${i} | wc -l)
    psinfo=$(ps --ppid ${i} -o pid,tname,time,cmd)
    ps_name=$(ps -ejH | grep ${i} | awk {'print $6 '} | uniq)
 
    if [ "$ps_count" -gt 5 ] && [ $i != 1 ] && [ $i != 2 ]; then

      echo -e "Process $i is running $ps_count child processes. Sending email to the system administrator !\n"      
      mail -s 'Process with more than 5 child processes is running!' $admin@$(hostname) <<< "You are receiving this because process $ps_name: $i is running at the moment $ps_count child processes, below is more info:

$psinfo" 
    fi
done

ps axjf >> /tmp/pstree.info

}

func_psmonitor
