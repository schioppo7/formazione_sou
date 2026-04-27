#!/bin/bash
#Save in/rootthefilespasswd,shadow, group,andgshadow

FILE1=/etc/passwd
FILE2=/etc/group
FILE3=/etc/shadow
FILE4=/etc/gshadows

DESTINATION=/root

clear

echo "Starting backup of files: $FILE1, $FILE2, $FILE3, $FILE4 to $DESTINATION"

cp $FILE1 $FILE2 $FILE3 $FILE4 $DESTINATION

echo "Backup completed successfully!"