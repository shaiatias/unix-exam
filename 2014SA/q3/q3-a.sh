#! /usr/bin/awk -f

BEGIN {
    pairs = ARGV[1]
    # ARGV[1] = ARGV[2]
    delete ARGV[1]

    size = split(pairs, splitted, ",")

    for (i=1; i <= size; i++) {
        
        if ( i % 2 == 0 ) {
            values[i/2] = splitted[i]
        }

        else {
            keys[(i/2)+0.5] = splitted[i]
        }
    }

    sum=0
}

{
    for (i in keys) {

        if ( FNR == keys[i] && values[i] <= NF ) {
            sum = sum + $(values[i])
        }
    }
}

END {
    print sum
}