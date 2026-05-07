#!/bin/bash


lista_della_frutta=("MELA" "MELA" "Mela" "Arancia" "mela" "Pera" "Fragola" "Banana" "pera" "pera") 

declare -A contatore #Array associativo per non avere duplicati

echo "Lista ordinata:"
for frutto in "${lista_della_frutta[@]}"; do 
    minuscolo="${frutto,,}" #Converte il nome del frutto in minuscolo scorciatoia senza chiamare comandi

    contatore["$minuscolo"]=1 #Inizializza il contatore per il frutto se non esiste già
done

printf "%s\n" "${contatore[@]}" | sort #Stampa l'elenco dei frutti unici in ordine alfabetico
