#! /bin/bash

function isCopyAvailable(){
        
    local book="$1"
    local found=0

    while read line; do

        copyId=$(echo $line | cut -d":" -f1)
        currBook=$(echo $line | cut -d":" -f2)
        isTaken=$(echo $line | cut -d":" -f4)
        
        if [ "$book" == "$currBook" ] && [ "$isTaken" == "-" ]; then
            echo -n "$copyId "
            found=$[$found+1]
        fi

    done < q4.txt

    echo ""

    if [ "$found" == "0" ]; then
        echo "No available copy"
    fi
}


function printPopularReport(){
    
    cat q4.txt | cut -d":" -f2 | uniq -c | sort -nr >| tmp

    while read line; do
    
        book=$( echo $line | cut -d" " -f2- )
        count=$( echo $line | cut -d" " -f1 )
        
        echo "$book $count"

    done < tmp
}

function returnCopy(){
    >| "tmp"
    
    local copyId="$1"

    while read line; do

        currCopyId=$(echo $line | cut -d":" -f1)        

        resStart=$(echo $line | cut -d":" -f4)
        resEnd=$(echo $line | cut -d":" -f5)
        
        if [ "$copyId" == "$currCopyId" ] && [ "$resStart" != "-" ] && [ "$resEnd" == "-" ]; then
            
            partOne=$( echo $line | cut -d":" -f1-4 )
            formattedDate=$( date +%d/%m/%y )
            echo "$partOne:$formattedDate" >> tmp

        else
            echo "$line" >> tmp
        fi

    done < q4.txt

    mv -f tmp q4.txt
}

if [ $1 == "avaliable-copy" ] ; then
    isCopyAvailable "$2"
elif [ $1 == "popular-books-report" ] ; then
    printPopularReport
elif [ $1 == "return-copy" ] ; then
    returnCopy $2
fi