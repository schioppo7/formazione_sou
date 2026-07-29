#!/bin/bash

DIRECTORY="/home/davide/disk_fill_test"
FILE_NAME="$DIRECTORY/corrupted_file.dat
mkdir -p $DIRECTORY

echo
echo "starting implosion procedure"


if ! cat /dev/zero >> "$FILE_NAME"
then
	echo "DISK FULL!!!!!"
	exit 1
fi


##################################################
#!/bin/bash

DIRECTORY="/home/davide/disk_fill_test"
mkdir -p "$DIRECTORY"

echo
echo "starting implosion procedure"

for ((i=1; i<=30; i++))
do
	FILE_NAME="$DIRECTORY/corrupted_file$i.dat"
	dd if =/dev/urandom of="$FILE_NAME" bs=1M count=5000 2> dev/null

	STATUS=$?
	if [ $STATUS -ne 0]; then
		echo "DISK FULL!!!!! Code: "$STATUS"
		exit 1
	fi
done
