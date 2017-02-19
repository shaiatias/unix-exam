#!/usr/bin/awk -f

function countline(file, count) {

    count = 0
    
    while ( (getline line < file) > 0) {
        # print file, line, count
        count++
    }

    close(file)

    return count
}

{   

    founderror = false

    count = countline(FILENAME)

    # print FILENAME, count

    arrsize = split($0, arr)
    diff = arr[0] - arr[1]

    for (i=1; i <= arrsize; i++) {
        
        nextdiff = arr[i-1] - arr[i]

        if (diff != nextdiff) {

            badfiles[badfileslength++] = FILENAME
            
            founderror = true
            nextfile
            break
        }
    }

    print FILENAME, FNR, count

    if (count == FNR && founderror == false) {
        print "good file", FILENAME
    }

    # print "NR -> " NR " ,FNR -> " FNR " ,NF -> " NF
    # command = "wc -l " FILENAME " | cut -d\" \" -f1"
}

END {
    for (i=0; i < badfileslength; i++){
        print badfiles[i]
    }
}