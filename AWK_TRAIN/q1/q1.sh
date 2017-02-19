#! /usr/bin/awk -f

BEGIN {

}

{
    for ( i=NF; i>0; i-- ){
        printf $i " "
    }

    print ""

    # if ( NF == 1 ){
    #     print $0
    # }

    # else if ( NF % 2 ) {
    #     print $0, "odd"
    # }

    # else {
    #     print $0, "even"
    # }
}

END {

}