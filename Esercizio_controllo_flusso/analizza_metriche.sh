#!/bin/zsh

# ARRAY
UNIQUE_SERVERS=("srv-web01" "srv-db02" "srv-auth01" "srv-cache03")

# ARRAY ASSOCIATIVI
declare -A cpu_somma
declare -A server_contatore

# Lettura del file e popolamento degli array associativi
while read -r server cpu; do 

    cpu_somma[$server]=$(( cpu_somma[$server] + cpu ))
    server_contatore[$server]=$(( server_contatore[$server] + 1 ))

done < metriche.txt

# Calcolo media e stampa del report
echo "=== REPORT UTILIZZO MEDIO CPU ==="

for server in "${UNIQUE_SERVERS[@]}"; do

    media=$(( cpu_somma[$server] / server_contatore[$server] ))
    echo "$server: $media%"

done