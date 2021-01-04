#!/bin/bash
#DEFAULT_NIC=

INTERFACE_COLUMN_NUM=`route | head -2 | tail -1 | awk '{
column_num=split($0,columns," ")
for (i=1;i<=column_num;i++) {
  if (match(columns[i],"(インタフェース|Iface)") == 1){
    interface_column=i
  }
  print interface_column
}
}
'`

DEFAULT_NIC=`route | grep "default" | awk -v interface_column_num="$INTERFACE_COLUMN_NUM" '{
column_num=split($0,columns," ")
for (i=1;i<=column_num;i++) {
  if (i == interface_column_num){
    print columns[i]
  }
}
}'`

SSID_OR_ETHER=`nmcli -t -f state,type,device,connection dev status | grep $DEFAULT_NIC | awk -F':' '{print $4}' | awk -F' ' '{print $1}'`

if [ -p ${SSID_OR_ETHER} ]; then
  echo "#[fg=colour1] Not Connected #[default]"
  exit
fi

echo -n ${SSID_OR_ETHER}
exit
