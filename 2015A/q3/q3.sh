#! /usr/bin/awk -f

BEGIN {
    
    split(ARGV[1], inputs, ":")

    for (i in inputs) {
        sums[i] = 0
    }

    if (ARGC == 2) {
        ARGV[1] = "zichron.txt"
    }

    else if (ARGC == 3) {
        ARGV[1] = ARGV[2]
        delete ARGV[2]
    }
}

{
    for (i in inputs){

        split(inputs[i], arguments, ",")

        if ($2 == arguments[1] && $5 == arguments[2]) {
            sums[i] = sums[i] + ($3 * $4)
        }
    }
}

END {

    for (i in inputs) {
        split(inputs[i], arguments, ",")
        print arguments[1], arguments[2], sums[i] > "tmp"
    }

    system("sort -k 3nr tmp")
}