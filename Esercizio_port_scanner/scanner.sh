#!/bin/bash

# Qui eseguo la sanificazione degli input controllando la validità
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <IP> <porta_inizio> <porta_fine>"
    exit 1
fi

IP=$1
INIZIO=$2
FINE=$3

# Controllo che l'IP sia valido (4 ottetti)
IFS='.' read -r o1 o2 o3 o4 o5 <<< "$IP"
if [ -n "$o5" ]; then
    echo "Indirizzo IP non valido"
    exit 1
fi

if (( INIZIO > FINE )); then
    echo "Range porte non valido"
    exit 1
fi

echo "Scansione su $IP da $INIZIO a $FINE..."
for port in $(seq $INIZIO $FINE); 
do
    nc -w 1 "$IP" "$port" <<< "" && echo "Porta $port APERTA"  
done

echo "Fine scansione"


