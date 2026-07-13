#!/bin/bash

names_file="../data/names.txt"

# how many random numbers to generate per name — pick a random count each time
min_count=1
max_count=10

# range for the random numbers themselves
min_num=1
max_num=1000

while IFS= read -r name; do
    [ -z "$name" ] && continue

    output_file="${name}.out"
    > "$output_file"   # clear/create the file fresh

    # pick a random number of lines for this name
    count=$(( RANDOM % (max_count - min_count + 1) + min_count ))

    for (( i=0; i<count; i++ )); do
        number=$(( RANDOM % (max_num - min_num + 1) + min_num ))
        echo "$name $number" >> "$output_file"
    done
done < "$names_file"
