#!/bin/bash
# This script checks the cpu temperature every 5 seconds;
#
# The systemd service file is: /etc/systemd/system/cputemp.service:
# [Unit]
# Description=This is a cpu memory custom made daemon
#
# [Service]
# ExecStart=/bin/bash /root/bin/cpu_temp_service.sh
#
# [Install]
# WantedBy=default.target
#
# Hit after `systemctl daemon-reload` to make systemd familiar with the new service;
#
# ...and start it with `systemctl start cputemp`
#
# Created by:      G.Petrov 12/12/2020
# Last updated by: G.Petrov 12/12/2020
#

date=$(date +%d/%m/%Y_%M:%H:%S:)
cpu_temp=$(sensors | grep Core | tr '+.' ' ' | awk {'print $3'})
log_file='/var/log/cpu_temp.log'

while :; do
  if [ $cpu_temp -gt 100 ]; then
    echo "${date}WARNING: The Core 0 temperature is HIGH: $cpu_temp !!!" &>> $log_file
  else
    echo "${date} The Core 0 temperature is at a normal level: $cpu_temp" &>> $log_file
  fi

  sleep 5
done
