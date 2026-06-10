
### 1. `generatore_log.sh` 

Questo script ha il solo scopo di **popolare l'ambiente di test** creando dei dati simulati su cui lavorare.

* **La logica:** Al suo interno ha un elenco fisso con i nomi dei 4 server aziendali. Avvia un ciclo che si ripete esattamente 100 volte.
* **L'azione:** Ad ogni giro del ciclo, lo script sceglie un server completamente a caso e gli associa un valore di utilizzo CPU inventato sul momento (sempre casuale, tra 10 e 99). Scrive poi questa coppia di dati nel file di testo.
* **La correzione del bug:** Nella traccia originale dello script era presente il simbolo `>` inserito erroneamente alla fine del ciclo. In ambiente Unix, quel carattere indica un reindirizzamento distruttivo che svuota i file: di fatto cancellava i log un millesimo di secondo dopo averli scritti. 

---

### 2. `metriche.txt` 

È il **file di output** prodotto dal primo script e funge da archivio temporaneo.

* **La struttura:** Non contiene codice, ma solo 100 righe di puro testo. Ogni riga rappresenta un singolo dato ed è composta sempre da due colonne separate da uno spazio: il nome del server e la percentuale di CPU rilevata in quel momento.
* **L'utilità:** Rappresenta lo storico dei log grezzi aziendali che un sistemista si troverebbe a dover analizzare.

---

### 3. `analizza_metriche.sh` 

È lo script principale che risolve il problema matematico richiesto dall'esercizio, trasformando i dati grezzi in un report pulito.

* **Fase di lettura:** Apre il file `metriche.txt` e lo legge riga per riga dall'alto verso il basso. Isola automaticamente il nome del server dal valore numerico della CPU.
* **Fase di smistamento (Array Associativi):** Utilizza due tabelle invisibili in memoria (chiamate array associativi) dove la "chiave" di ricerca è il nome del server. Man mano che legge le righe, lo script fa due cose contemporaneamente: in una tabella somma i valori di CPU e nell'altra conta quante volte quel server è apparso.
* **Fase di calcolo e output:** Una volta letto tutto il file, lo script prende la somma totale della CPU di ogni server, la divide per il rispettivo numero di apparizioni e stampa a schermo la media finale in formato percentuale.
