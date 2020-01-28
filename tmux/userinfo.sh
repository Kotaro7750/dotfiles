#!/bin/bash
TTY=`ps -p $2 -o tty -h`
SSHCOMMAND=`ps -o pid,tty,command -h | grep ${TTY} | grep "ssh" | sed -e 's/   */ /g' | cut -d ' ' -f 3- | grep ^ssh`

SSH_USER_AND_HOST=`echo ${SSHCOMMAND} | sed -e 's/ /\n/g' | grep -E '.+@.+'`

USER=`who | grep ${TTY} | awk -F' ' '{print $1}'`
HOST=`hostname`

if [ ${#SSHCOMMAND} -gt 0 ]; then
  echo ${SSH_USER_AND_HOST}
  tmux select-pane -t $1 -P 'bg=colour023'
else
  echo ${USER}@${HOST}
  tmux select-pane -t $1 -P 'default'
fi

