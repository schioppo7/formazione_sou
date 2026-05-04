# Script di Controllo Processi

Questo script Bash esegue una serie di controlli sui processi di sistema e crea una directory se non esiste. È progettato per essere eseguito come root.

## Requisiti

- Deve essere eseguito come utente root.
- Shell Bash.

## Funzionalità

1. **Controllo Root**: Verifica se lo script è eseguito dall'utente root. Esce con un errore se non lo è.

2. **Creazione Directory**: Tenta di creare `/root/cartella_permessi`. Se esiste già, informa l'utente.

3. **Analisi Processi**: Controlla la presenza di processi specifici:
   - md
   - systemd
   - processo_zombie
   - ssh

   Per ciascun processo, riporta se è attivo o meno. Conta il numero di processi inattivi.

4. **Conteggio Totale Processi**: Conta il numero totale di processi in esecuzione sul sistema utilizzando `ps aux`.

5. **Riepilogo**: Stampa un riepilogo finale che include:
   - Processi totali trovati.
   - Numero di problemi (processi inattivi dalla lista controllata).