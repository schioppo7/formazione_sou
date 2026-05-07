# Esercizio Stringhe duplicati, ordinare e conversione

Riassunto dell'esercizio: ordinare, togliere i duplicati e convertire in lowercase una lista di stringhe utilizzando diversi approcci (Unix Pipeline, Bash Script e Python).

## 1. Soluzione Unix Pipeline
Utilizzo degli strumenti classici di "filtro" Unix tramite pipe.

cat frutta.txt | tr '[:upper:]' '[:lower:]' | sort | uniq


**Logica del comando:**
* `cat frutta.txt`: legge il file.
* `|`: "pipeline", prende l'output di cat e lo passa al comando successivo.
* `tr '[:upper:]' '[:lower:]'`: trasforma tutto in minuscolo.
* `sort`: ordina le righe seguendo l'alfabeto.
* `uniq`: elimina le righe duplicate.


## 2. Soluzione Bash Script
Soluzione tramite un ciclo e utilizzo degli array associativi.

```bash
#!/bin/bash

lista_della_frutta=("MELA" "MELA" "Mela" "Arancia" "mela" "Pera" "Fragola" "Banana" "pera" "pera") 

declare -A contatore # Array associativo per non avere duplicati

echo "Lista ordinata:"
for frutto in "${lista_della_frutta[@]}"; do 
    minuscolo="${frutto,,}" # Converte il nome del frutto in minuscolo (scorciatoia)

    contatore["$minuscolo"]=1 # Inizializza il contatore per il frutto se non esiste già, ad ogni elemento gli viene assegnato 1 così da sovrascrivere in caso di duplicati
done

printf "%s\n" "${!contatore[@]}" | sort # Stampa i frutti unici in ordine alfabetico
```


## 3. Soluzione Python (Bonus Extra)
Versione utilizzando la sintassi di python

```python
print(sorted({frutta.lower() for frutta in ["pera", "pera", "MELA", "Mela", "BANANA"]}))
```


## Requisiti
* Bash 4.0 o superiore.
* Ambiente Unix-like per i comandi di pipeline.