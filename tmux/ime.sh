#!/bin/bash
FCITX_MODE=`fcitx-remote`

if [ $FCITX_MODE = "2" ] ; then
  echo "A"
  exit
else 
  if [ $FCITX_MODE = "1" ] ; then
    echo "あ"
    exit
  else
    echo "Fcitx isn't working"
  fi
fi
