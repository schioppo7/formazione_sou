#!/bin/bash

DOCKER="/usr/bin/docker" 
DATE="/usr/bin/date" 
HOSTNAME="/usr/bin/hostname" 

# Variabili per ottenere il minuto corrente e il nome dell'host
MINUTE=$($DATE +%M) 
IO=$($HOSTNAME) 

# Blocchi condizionali per migrare il container tra i due nodi ogni 60 secondi
if [ $(($MINUTE % 2)) -eq 0 ]; then # Se il minuto è pari, il container va su node1, in tutti gli altri casi node2
    TARGET="node1"
else
    TARGET="node2" 
fi

# Controlliamo se siamo sul nodo voluto, avviandolo in caso
if [ "$IO" == "$TARGET" ]; then 
    if [ ! "$($DOCKER ps -a -q -f name=ping)" ]; then # Se il container ping non esiste, lo avviamo
        $DOCKER run -d --name ping -p 8080:80 ping
    else
        # Se il container esiste ma in stop lo avviamo
        if [ ! "$($DOCKER ps -q -f name=ping)" ]; then
            $DOCKER start ping
        fi
    fi
else
    # Se non siamo sul nodo voluto, stoppiamo il container 
    if [ "$($DOCKER ps -q -f name=ping)" ]; then
        $DOCKER stop ping
    fi
fi
