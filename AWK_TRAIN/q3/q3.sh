#! /usr/bin/awk -f

BEGIN {

}

{
    originalLine = $0
    
    gsub(/[^a-zA-Z]/, "")
    
    print FILENAME " " length($0) ":" originalLine
}

END {

}