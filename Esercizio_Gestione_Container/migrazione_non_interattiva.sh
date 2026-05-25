#!/bin/bash

#Attori sulla riva 1 (0) e sulla riva 2 (1)
UOMO=0
LUPO=0
CAPRA=0
CAVOLO=0

#Funzione per verificare se la configurazione attuale soddisfa i vincoli del problema
funzione_constraint() {
    local step_corrente=$1

    # Verifica se il cavolo e la capra sono insieme senza l'uomo
    if [ "$CAPRA" -eq "$CAVOLO" ] && [ "$UOMO" -ne "$CAPRA" ]; then
        echo "$step_corrente fallito:La capra e il cavolo sono insieme senza l'uomo! Configurazione non valida."
        exit 1
    fi
    # Verifica se il lupo e la capra sono insieme senza l'uomo
    if [ "$LUPO" -eq "$CAPRA" ] && [ "$UOMO" -ne "$LUPO" ]; then
        echo "$step_corrente fallito:Il lupo e la capra sono insieme senza l'uomo! Configurazione non valida."
        exit 1
    fi

    echo " PASSAGGIO $step_corrente riuscito: Configurazione valida."
}

#Funzione per migrare un container da una riva all'altra
migrazione_container() {
    local asset=$1 #nome del container da migrare
    local direzione=$2 # "andata" o "ritorno"
    local source_riva="riva1" 
    local target_riva="riva2"

    if [ "$direzione" -eq 0 ]; then
        source_riva="riva2"
        target_riva="riva1"
    fi

    echo "Migrazione di $asset da $source_riva a $target_riva"

    #Rimuove il container dalla riva di origine e lo avvia sulla riva di destinazione
    vagrant ssh "$source_riva" -c "docker rm -f $asset" > /dev/null 2>&1
    vagrant ssh "$target_riva" -c "docker run -d --name $asset alpine sleep infinity" > /dev/null 2>&1
}

clear
echo 
echo "       AVVIO PROCESSO DI MIGRAZIONE AUTOMATIZZATO (NON INTERATTIVO)   "
echo 

#Passaggio 1
echo "Passo 1: Uomo porta la capra sulla riva 2"
UOMO=1
CAPRA=1
funzione_constraint 1
migrazione_container "uomo" 1
migrazione_container "capra" 1

#Passaggio 2
echo "Passo 2: Uomo torna da solo sulla riva 1"
UOMO=0
funzione_constraint 2
migrazione_container "uomo" 0

#Passaggio 3
echo "Passo 3: Uomo porta il lupo sulla riva 2"
UOMO=1
LUPO=1
funzione_constraint 3
migrazione_container "uomo" 1
migrazione_container "lupo" 1

#Passaggio 4
echo "Passo 4: Uomo torna con la capra sulla riva 1"
UOMO=0
CAPRA=0
funzione_constraint 4
migrazione_container "uomo" 0
migrazione_container "capra" 0

#Passaggio 5
echo "Passo 5: Uomo porta il cavolo sulla riva 2"
UOMO=1
CAVOLO=1
funzione_constraint 5
migrazione_container "uomo" 1
migrazione_container "cavolo" 1

#Passaggio 6
echo "Passo 6: Uomo torna da solo sulla riva 1"
UOMO=0
funzione_constraint 6
migrazione_container "uomo" 0

#Passaggio 7
echo "Passo 7: Uomo porta la capra sulla riva 2"
UOMO=1
CAPRA=1
funzione_constraint 7
migrazione_container "uomo" 1
migrazione_container "capra" 1


echo "Tutti gli asset sono stati traghettati con successo sulla riva 2!"

echo
echo "Stato finale dei container su RIVA 1:"
vagrant ssh riva1 -c "docker ps --format '{{.Names}}'"
echo
echo "Stato finale dei container su RIVA 2:"
vagrant ssh riva2 -c "docker ps --format 'table {{.Names}}\t{{.Status}}'"
echo
echo "Processo brute-force completato con successo!"

