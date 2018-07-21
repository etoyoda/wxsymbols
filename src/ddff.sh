#!/bin/sh

cd $(dirname $0)

dd=00
while (( ++dd <= 1 ))
do
  ff=00
  while (( ( ff += 5 ) <= 95 ))
  do
    ruby -I. ddff-windbarb.rb $dd $ff ../img/d${dd}f${ff}.png
  done
done
