#! /usr/bin/awk -f

BEGIN {

    input = ARGV[1]

    for (i = 2; i < ARGC; i++) {
        ARGV[i-1] = ARGV[i]
    }

    delete ARGV[ARGC-1]
}

{
    if (FNR == 1) {

        print FILENAME
        system("q3.sh " input " " FILENAME)
    }
}