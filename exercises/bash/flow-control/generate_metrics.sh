#!/bin/bash
# Run this script to generate the 100-line metrics.txt file
SERVER_LIST=("srv-web01" "srv-db02" "srv-auth01" "srv-cache03")
OUTPUT_FILE="metrics.txt"

# Empties the file if it already exists
> "$OUTPUT_FILE"

echo "Generating 100 lines..."

for i in {1..100}; do
# Selects a random server from the array
random_server=${SERVER_LIST[$((RANDOM % 4))]}
# Generates a random CPU value between 10 and 99
random_cpu=$((RANDOM % 90 + 10))
# Writes to the file
echo "$random_server $random_cpu" >> "$OUTPUT_FILE"
done

echo "File '$OUTPUT_FILE' generated successfully!"
