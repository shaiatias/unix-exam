#! /bin/bash

function sumfile() {

    # check for NAN in file
    containstext=$( cat $1 | tr " " "0" | egrep [^0-9-] )

    if [ "$containstext" != "" ]; then
        return 0
    fi
    
    # if no text in file, sum the numbers in it

    local sum=0

    while read line; do

        for num in $line ; do
            sum=$[$sum + $num]
        done

    done < $1

    # return 0 if (sum < 0) 

    if [ $sum -lt 0 ]; then
        return 0
    else
        return 1
    fi    
}

sumfile goodfile1
echo "result -> $?"