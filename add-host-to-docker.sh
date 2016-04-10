#!/bin/sh

REQUIRED_ENVS='CONTAINER HOST'

for n in $REQUIRED_ENVS
do
  eval v=\$$n
  if [ -z "$v" ]; then
    ENVS_ERRORS=true
    echo "ENV $n does not exist"
  fi
done

if [ "$ENVS_ERRORS" = true ]; then
  exit 1
fi

IP=`getent hosts $HOST | awk '{ print $1 }'`
if [ -n "$IP" ]; then
  CONTAINER_ID=`docker ps | awk "/$CONTAINER/{print \\$1}"`
  if [ -n "$CONTAINER_ID" ]; then
    echo "Add $HOST($IP) to $CONTAINER($CONTAINER_ID)"
    docker exec $CONTAINER_ID sh -c "echo $IP $HOST >> /etc/hosts"
  fi
fi
