#!/bin/bash
TTY=`ps -p $2 -o tty -h`
SSH=`ps -o pid,tty,command -h | grep ${TTY} | grep "ssh"`

if [ ${#SSH} -gt 0 ]; then
  tmux select-pane -t $1 -P 'bg=colour023'
else
  tmux select-pane -t $1 -P 'default'
fi

