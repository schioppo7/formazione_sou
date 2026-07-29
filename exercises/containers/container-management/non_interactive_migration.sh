#!/bin/bash

# Actors on side 1 (0) and side 2 (1)
FARMER=0
WOLF=0
GOAT=0
CABBAGE=0

# Check whether the current configuration satisfies the puzzle constraints
check_constraints() {
    local current_step=$1

    # Check whether the cabbage and the goat are together without the farmer
    if [ "$GOAT" -eq "$CABBAGE" ] && [ "$FARMER" -ne "$GOAT" ]; then
        echo "$current_step failed: The goat and the cabbage are together without the farmer! Invalid configuration."
        exit 1
    fi
    # Check whether the wolf and the goat are together without the farmer
    if [ "$WOLF" -eq "$GOAT" ] && [ "$FARMER" -ne "$WOLF" ]; then
        echo "$current_step failed: The wolf and the goat are together without the farmer! Invalid configuration."
        exit 1
    fi

    echo " STEP $current_step completed: Valid configuration."
}

# Move a container from one side to the other
migrate_container() {
    local asset=$1 # Name of the container to move
    local direction=$2 # "outbound" or "return"
    local source_side="side1"
    local target_side="side2"

    if [ "$direction" -eq 0 ]; then
        source_side="side2"
        target_side="side1"
    fi

    echo "Moving $asset from $source_side to $target_side"

    # Remove the container from the source side and start it on the target side
    vagrant ssh "$source_side" -c "docker rm -f $asset" > /dev/null 2>&1
    vagrant ssh "$target_side" -c "docker run -d --name $asset alpine sleep infinity" > /dev/null 2>&1
}

clear
echo
echo "       STARTING AUTOMATED MIGRATION PROCESS (NON-INTERACTIVE)   "
echo

# Step 1
echo "Step 1: The farmer takes the goat to side 2"
FARMER=1
GOAT=1
check_constraints 1
migrate_container "farmer" 1
migrate_container "goat" 1

# Step 2
echo "Step 2: The farmer returns alone to side 1"
FARMER=0
check_constraints 2
migrate_container "farmer" 0

# Step 3
echo "Step 3: The farmer takes the wolf to side 2"
FARMER=1
WOLF=1
check_constraints 3
migrate_container "farmer" 1
migrate_container "wolf" 1

# Step 4
echo "Step 4: The farmer returns with the goat to side 1"
FARMER=0
GOAT=0
check_constraints 4
migrate_container "farmer" 0
migrate_container "goat" 0

# Step 5
echo "Step 5: The farmer takes the cabbage to side 2"
FARMER=1
CABBAGE=1
check_constraints 5
migrate_container "farmer" 1
migrate_container "cabbage" 1

# Step 6
echo "Step 6: The farmer returns alone to side 1"
FARMER=0
check_constraints 6
migrate_container "farmer" 0

# Step 7
echo "Step 7: The farmer takes the goat to side 2"
FARMER=1
GOAT=1
check_constraints 7
migrate_container "farmer" 1
migrate_container "goat" 1


echo "All assets have been moved successfully to side 2!"

echo
echo "Final container state on SIDE 1:"
vagrant ssh side1 -c "docker ps --format '{{.Names}}'"
echo
echo "Final container state on SIDE 2:"
vagrant ssh side2 -c "docker ps --format 'table {{.Names}}\t{{.Status}}'"
echo
echo "Brute-force process completed successfully!"
