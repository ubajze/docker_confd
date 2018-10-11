#!/bin/bash

CMD=$1
ATTR=$2

NCPORT=2022
SSHPORT=2024

NCRANGE=4000
SSHRANGE=5000

i=0

if [ $CMD == "start" ]; then
  if [ -n "$ATTR" ] && [ $ATTR -eq $ATTR ] 2>/dev/null; then
    while [ $i -lt $ATTR ]; do
      docker run -d -p $[$NCRANGE+$i+1]:$NCPORT -p $[$SSHRANGE+$i+1]:$SSHPORT confd
      i=$[$i+1]
    done
    exit 0
  else
    echo "Integer is required as an attribute"
    exit 1
  fi
fi

if [ $CMD == "stop" ]; then
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
  exit 0
fi

echo "Only start and stop commands are supported."
exit 1
