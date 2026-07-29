#!/bin/zsh

# ARRAY
UNIQUE_SERVERS=("srv-web01" "srv-db02" "srv-auth01" "srv-cache03")

# ASSOCIATIVE ARRAYS
declare -A cpu_sum
declare -A server_count

# Reads the file and fills the associative arrays
while read -r server cpu; do

    cpu_sum[$server]=$(( cpu_sum[$server] + cpu ))
    server_count[$server]=$(( server_count[$server] + 1 ))

done < metrics.txt # Reads the file line by line, extracts the server name and CPU value, and updates the total CPU sum and count for each server.

# Calculates the average and prints the report
echo "=== AVERAGE CPU USAGE REPORT ==="

for server in "${UNIQUE_SERVERS[@]}"; do

    average=$(( cpu_sum[$server] / server_count[$server] ))
    echo "$server: $average%"

done
