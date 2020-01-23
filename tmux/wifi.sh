#!/bin/bash
SSID=`nmcli -t -f state,type,device,connection dev status | grep wifi | awk -F':' '{print $4}'`

if [ -p ${SSID} ]; then
  echo "#[fg=colour1] Not Connected #[default]"
  exit
fi

echo -n ${SSID}
exit
