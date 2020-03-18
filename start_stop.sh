#!/bin/sh

### BEGIN INIT INFO
# Provides:          Storage info
# Required-Start:    networking
# Required-Stop:     networking
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Checks used storage space
# Description:       This script is checking root directory size upon
#                    starting the system.
#                    Do not forget the symbolic links between /etc/rc.d/init.d/ and /etc/rc*.d/ directories !
### END INIT INFO

show_info="yes"
info_file="/home/cloud_user/storage_usage.info"

do_start () {
  if [ "$show_info" == "yes" ]; then
    du -sm / | awk {'print $1'} > $info_file 2> /dev/null
  fi   
}

do_stop () {
  rm -rf $info_file
}

do_restart () {
  do_stop
  do_start
}

case "$1" in
  start)
    do_start
  ;;
  stop)
    do_stop
  ;;
  restart)
    do_restart
  ;;
  *)
    echo "Usage -> {start|stop|restart}"
    exit 1
  ;;
esac
