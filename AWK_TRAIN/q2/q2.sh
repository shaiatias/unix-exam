#! /usr/bin/awk -f

BEGIN {
    max = ARGV[2]
    delete ARGV[2]
}

{
    for (i=1; i <= NF; i++) {
        
        if ( length($i) > max ){
            print $i
        }
    }
}

END {

}