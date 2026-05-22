# Cloud Migration Orchestrator: Il Problema del Traghettamento

Questo progetto implementa una metafora DevOps basata sul classico enigma logico del lupo, della capra e del cavolo. L'obiettivo è migrare tre asset (container/microservizi) e un orchestratore (Control Plane) da un ambiente iniziale (**Riva 1**) a un ambiente finale (**Riva 2**) rispettando vincoli di isolamento e sicurezza.

## Architettura del Sistema

Il sistema mappa gli elementi del problema tradizionale su componenti di un'infrastruttura IT:

| Elemento Originale | Componente Architetturale | Descrizione |

| **Fiume** | Rete Privata Vagrant | Canale di comunicazione e barriera tra i due ambienti. |
| **Riva 1** | Virtual Machine 1 (`riva1`) | Ambiente sorgente iniziale gestito tramite Vagrant. |
| **Riva 2** | Virtual Machine 2 (`riva2`) | Ambiente target finale gestito tramite Vagrant. |
| **Uomo** | Orchestratore | Agisce sia come Control Plane (logica dei movimenti) sia come garante fisico della sicurezza |
| **Lupo / Capra / Cavolo** | Container Docker | Microservizi basati su immagini minimali (`alpine`). |

---

## Condizioni di Isolamento (Constraint Enforcement)

L'orchestratore esegue una simulazione dello stato logico prima di applicare qualsiasi comando reale di switch sui container (`docker run` o `docker rm`). Se lo stato futuro viola una delle seguenti regole, la transizione viene bloccata:

1. **Capra + Cavolo** nella stessa Virtual Machine senza l'Uomo $\rightarrow$ **Fallimento** (il cavolo viene eliminato).
2. **Lupo + Capra** nella stessa Virtual Machine senza l'Uomo $\rightarrow$ **Fallimento** (la capra viene eliminata).

---

## Prerequisiti

Prima di eseguire gli script, assicurati di avere installato e configurato sul tuo host:
* [Vagrant](https://www.vagrantup.com/)
* Un provider compatibile (es. VirtualBox, VMware o Parallels)
* Le due VM (`riva1` e `riva2`) avviate, con la rete privata configurata e Docker installato al loro interno.
