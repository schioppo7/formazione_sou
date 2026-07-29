#!/bin/bash
echo "Initializing the container state on SIDE 1"

vagrant ssh side1 -c "
  echo 'Removing old containers'
  docker rm -f farmer wolf goat cabbage 2>/dev/null

  echo 'Starting the 4 containers: Farmer, Wolf, Goat, and Cabbage'
  docker run -d --name farmer alpine sleep infinity
  docker run -d --name wolf alpine sleep infinity
  docker run -d --name goat alpine sleep infinity
  docker run -d --name cabbage alpine sleep infinity

  echo -e 'Current container state on SIDE 1:'
  docker ps --format 'table {{.Names}}\t{{.Status}}'
"

echo "Initializing the container state on SIDE 2"


vagrant ssh side2 -c "
  docker rm -f farmer wolf goat cabbage 2>/dev/null
  echo 'Side 2 is empty and ready to receive the containers.'
"
