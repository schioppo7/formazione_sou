#!/bin/bash

DOCKER="/usr/bin/docker"
DATE="/usr/bin/date"
HOSTNAME="/usr/bin/hostname"

# Variables used to get the current minute and hostname
MINUTE=$($DATE +%M)
CURRENT_NODE=$($HOSTNAME)

# Conditional blocks used to move the container between the two nodes every 60 seconds
if [ $(($MINUTE % 2)) -eq 0 ]; then # On even minutes the container goes to node1; otherwise, it goes to node2
    TARGET="node1"
else
    TARGET="node2"
fi

# Check whether this is the target node and start the container if needed
if [ "$CURRENT_NODE" == "$TARGET" ]; then
    if [ ! "$($DOCKER ps -a -q -f name=ping)" ]; then # Start the ping container if it does not exist
        $DOCKER run -d --name ping -p 8080:80 ping
    else
        # Start the container if it exists but is stopped
        if [ ! "$($DOCKER ps -q -f name=ping)" ]; then
            $DOCKER start ping
        fi
    fi
else
    # Stop the container when this is not the target node
    if [ "$($DOCKER ps -q -f name=ping)" ]; then
        $DOCKER stop ping
    fi
fi
