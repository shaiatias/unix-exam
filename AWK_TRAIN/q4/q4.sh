#! /usr/bin/awk -f

BEGIN {

}

{
    gsub(/[0-9][0-9]/, "N", $2)
    print $0
}

END {

}