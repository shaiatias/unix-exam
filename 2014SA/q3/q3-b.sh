#! /usr/bin/awk -f

BEGIN {
    pairs = ARGV[1]
    delete ARGV[1]

    for (i=2; i < ARGC; i++) {
        
        command = "q3-a.sh " pairs " " ARGV[i]
        
        command | getline sum 

        # system("q3-a.sh " pairs " " ARGV[i] " > tmp0")
        # getline sum < "tmp0"

        print ARGV[i], sum > "sums"        
    }
    
    system("sort sums")
}

END {
    
}