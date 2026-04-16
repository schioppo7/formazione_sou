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
mkdir -p "$DIRECTORY"

echo
echo "inizio procedura di implosione"

for ((i=1; i<=30; i++))
do
	NOME_FILE="$DIRECTORY/file_corrotto$i.dat"
	dd if =/dev/urandom of="$NOME_FILE" bs=1M count=5000 2> dev/null

	STATO=$?
	if [ $STATO -ne 0]; then
    		echo "DISCO PIENO!!!!! Codice: "$STATO"
    		exit 1
	fi
done




