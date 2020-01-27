#!/bin/bash
PERCENT=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk -F':' '{print $2}' | sed -s 's/ //g'| sed -s 's/%//g'` 
STATE=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | awk -F':' '{print $2}' | sed -s 's/ //g'| sed -s 's/%//g'` 

if [ $STATE = "charging" ]  || [ $STATE = "fully-charged" ] ; then
  echo "#[fg=colour118] ${PERCENT}% #[default]"
  exit
fi

if [ $PERCENT -ge 20 ] ; then
  echo "#[fg=colour33] ${PERCENT}% #[default]"
  exit
else
  echo "#[fg=colour1] ${PERCENT}% #[default]"
  exit
fi

