# Port Scanner Bash

Tool per la scansione di porte TCP in ambienti di rete isolati.

## Descrizione del Progetto
Il progetto consiste in un port scanner realizzato in Bash per testare la connettività tra due macchine virtuali su una rete privata. Lo script verifica quali porte sono aperte su un IP target, automatizzando il processo tramite un ciclo for.

## Logica di Funzionamento
Lo script si articola in tre fasi principali:

1. **Sanificazione degli input:**
   - **Controllo Argomenti:** Verifica tramite **$#** che siano stati passati esattamente 3 parametri (IP, porta inizio, porta fine).
   - **Validazione IP:** Per gestire l'IP, uso **IFS='.'** (Internal Field Separator) per suddividere l'indirizzo in ottetti. Verifico che la variabile risultante non contenga un quinto ottetto.
   - **Validazione Range:** Un controllo condizionale verifica che la porta di inizio non sia superiore alla porta di fine, evitando errori di logica nel ciclo.

2. **Scansione:**
   - Utilizzo il comando **seq** all'interno di un ciclo **for** per generare la sequenza di porte da testare.
   - Per ogni iterazione, invoco **nc -w 1 "$IP" "$port"**. Il flag **-w 1** è fondamentale: impone un timeout di un secondo, evitando che lo script si blocchi indefinitamente su porte chiuse.
   - L'operatore **&&** permette di stampare a video "APERTA" solo se il comando **nc** termina con successo "exit code 0"

## Comandi per l'uso
1. **Configurazione_Scanner:** Avvia la VM con **vagrant up** e accedi allo scansionatore con **vagrant ssh scansionatore**.
2. **Configurazione_Target:** Avvia la VM con **vagrant up** e accedi al target con **vagrant ssh scansionatore** ed aprire la porta voluta con il comando nc -lk 0.0.0.0 80 flag -l (listen), flag -k (keep alive).
3. **Permessi:** Rendi eseguibile lo script:
   chmod +x portscanner.sh
4. **Esecuzione:** Lancia lo script indicando il target e il range:
   ./scanner.sh 192.168.56.10 80 443
