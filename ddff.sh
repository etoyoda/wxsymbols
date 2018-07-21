#!/bin/sh

dd=00
while (( ++dd <= 36 ))
do
  ff=00
  while (( ( ff += 5 ) <= 95 ))
  do
    ruby -I. ddff-windbarb.rb $dd $ff d${dd}f${ff}.png
  done
done
