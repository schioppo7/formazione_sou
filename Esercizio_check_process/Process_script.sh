#!/bin/bash

#Definire le variabili
UTENTE=$(whoami)
PROCESS_LIMIT=7
CONTATORE=0


# Funzione per controllare se un processo è in esecuzione
check_process() {
    local servizio=$1 # Prende il nome del processo da controllare come argomento
    if pgrep  "$servizio" > /dev/null; then # Controlla se il processo è in esecuzione usando pgrep
        return 0 
    else
        return 1 
    fi
}



if [ $EUID -ne 0 ]; then # Controllo se l'utente è root
    echo "Errore: Questo script deve essere eseguito come utente root."
    exit 1 
fi



mkdir "/root/cartella_permessi" 2>/dev/null 
if [ $? -ne 0 ]; then # Controllo se la cartella è stata creata con successo e quindi lo status code è diverso da 0
    echo "La cartella_permessi esiste già."
else
    echo "Cartella creata con successo in /root."
fi




echo "Analisi dei processi per l'utente = $UTENTE"

PROCESS_TO_CHECK=("md" "systemd" "processo_zombie" "ssh")  # Elenco dei processi da controllare

for proc in "${PROCESS_TO_CHECK[@]}"; do 
    if check_process "$proc"; then 
        echo "il processo $proc è attivo"
    else
        echo "Il processo $proc non è attivo"
        ((CONTATORE++)) # Incrementa il contatore dei problemi trovati
    fi
done


# Controllo del numero totale di processi in esecuzione
PROCESSI_TOTALI=$(ps aux | wc -l)  # Conta il numero totale di processi in esecuzione usando ps e wc

echo "Riepilogo finale:"
echo "Processi totali trovati = $PROCESSI_TOTALI"
echo "Problemi trovati = $CONTATORE" # Stampa il numero di problemi trovati

exit 0
