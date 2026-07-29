#!/bin/bash

# Validates the input
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <IP> <start_port> <end_port>"
    exit 1
fi

IP=$1
START_PORT=$2
END_PORT=$3

# Checks whether the IP address is valid (4 octets)
if echo "$IP" | grep -eq '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'; then
    echo "The IP address is valid"
else
    echo "Invalid IP address"
    exit 1
fi


echo "Scanning $IP from port $START_PORT to port $END_PORT..."
for port in $(seq $START_PORT $END_PORT);
do
    nc -w 1 "$IP" "$port" <<< "" && echo "Port $port OPEN"
done

echo "Scan complete"
