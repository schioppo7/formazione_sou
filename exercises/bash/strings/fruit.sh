#!/bin/bash


fruit_list=("APPLE" "APPLE" "Apple" "Orange" "apple" "Pear" "Strawberry" "Banana" "pear" "pear")

declare -A counter # Associative array used to remove duplicates

echo "Sorted list:"
for fruit in "${fruit_list[@]}"; do
    lowercase_fruit="${fruit,,}" # Converts the fruit name to lowercase without calling commands

    counter["$lowercase_fruit"]=1 # Initializes the counter for the fruit if it does not already exist
done

printf "%s\n" "${counter[@]}" | sort # Prints the unique fruits in alphabetical order
