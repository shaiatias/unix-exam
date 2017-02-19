#! /bin/bash

function handleOneFolder(){
    local folder=$1
    
    >| tmp

    tree $folder -Fi | grep -v /$ >| tmp 
    
# cat tmp

    lines=$( wc -l tmp | cut -d" " -f1 )
    lines=$[$lines - 2]
# echo $lines
    filesinfolder=$(head -$lines tmp | tail -$[$lines - 1] | sort -u | wc -l)


    echo "$folder $filesinfolder"
}

for folder in "$@"; do
    handleOneFolder $folder
done