#! /bin/bash

>| tmp
>| tmpsorted

items="$1"

shift

for var in "$@"; do

    while read line; do

        product=$( echo $line | cut -d" " -f2 )
        amount=$( echo $line | cut -d" " -f3 )
        price=$( echo $line | cut -d" " -f4 )
        date=$( echo $line | cut -d" " -f5 )
        kupa=$( echo $line | cut -d" " -f1 )

        total=$[$amount * $price]

        echo "$product $date $var $kupa $total" >> tmp

    done < "../q3/$var"
done

sort tmp -k 1n,2n >> tmpsorted

last_product_date=""
last_snif_kupa=""
temp_sum=0

while read line; do

    product_date=$( echo $line | cut -d" " -f1-2 )
    snif_kupa=$( echo $line | cut -d" " -f3-4 )

    total=$( echo $line | cut -d" " -f5 )

    if [ "$last_product_date" == "" ]; then
        echo "$product_date"

        last_product_date="$product_date"
        last_snif_kupa="$snif_kupa"
        temp_sum=$total

    elif [ "$last_product_date" != "$product_date" ]; then
        echo "$last_product_date"
        echo "$last_snif_kupa $total"

        last_product_date="$product_date"
        last_snif_kupa="$snif_kupa"
        temp_sum=$total
    
    elif [ "$last_snif_kupa" != "$snif_kupa" ]; then
        echo "$last_snif_kupa $total"

        last_snif_kupa="$snif_kupa"
        temp_sum=$total
    else
        temp_sum=$[$temp_sum + $total]
    fi

done < tmpsorted

if [ "$last_snif_kupa" != "" ]; then
    echo "$last_snif_kupa $temp_sum"
fi