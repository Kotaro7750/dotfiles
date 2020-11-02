#!/bin/bash
isWSL(){
  CMDEXE=`which cmd.exe`
  UNAME=`uname -r | grep "microsoft"`
  if [ $CMDEXE = "" -o $UNAME = "" ] ; then
    return 1
  else
    return 0
  fi
}
