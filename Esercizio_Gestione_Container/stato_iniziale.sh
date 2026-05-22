#!/bin/bash
echo "Inizializzazione dello stato dei container su RIVA 1"

vagrant ssh riva1 -c "
  echo 'Pulizia di container vecchi'
  docker rm -f uomo lupo capra cavolo 2>/dev/null

  echo 'Avvio dei 4 container: Uomo, Lupo, Capra e Cavolo'
  docker run -d --name uomo alpine sleep infinity
  docker run -d --name lupo alpine sleep infinity
  docker run -d --name capra alpine sleep infinity
  docker run -d --name cavolo alpine sleep infinity

  echo -e 'Stato attuale dei container su RIVA 1:'
  docker ps --format 'table {{.Names}}\t{{.Status}}'
"

echo "Inizializzazione dello stato dei container su RIVA 2"


vagrant ssh riva2 -c "
  docker rm -f uomo lupo capra cavolo 2>/dev/null
  echo 'Riva 2 è vuota e pronta a ricevere i container.'
"