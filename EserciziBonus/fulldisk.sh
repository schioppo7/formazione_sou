#!/bin/bash

DIRECTORY="/home/davide/test_esplosione"
NOME_FILE="$DIRECTORY/file_corrotto.dat
mkdir -p $DIRECTORY

echo
echo "inizio procedura di implosione"


if ! cat /dev/zero >> "$NOME_FILE"
then
	echo "DISCO PIENO!!!!!"
	exit 1
fi


##################################################
#!/bin/bash

DIRECTORY="/home/davide/test_esplosione"
NOME_FILE="$DIRECTORY/file_corrotto.dat"
mkdir -p "$DIRECTORY"

echo
echo "inizio procedura di implosione"

if ! dd if=/dev/urandom of="$NOME_FILE" bs=1M count = 1000  2> /dev/null
then
    echo "DISCO PIENO!!!!!"
    exit 1
fi





