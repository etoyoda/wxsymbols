#!/bin/sh

cd $(dirname $0)

dd=1
while expr $dd '<=' 36 >/dev/null
do
  ff=5
  while expr $ff '<=' 100 >/dev/null
  do
    ruby -I. ddff-windbarb.rb $dd $ff ../img/d${dd}f${ff}.png
    ff=`expr $ff + 5`
  done
  for ff in 110 120 130 150 200 250
  do
    ruby -I. ddff-windbarb.rb $dd $ff ../img/d${dd}f${ff}.png
  done
  dd=`expr $dd + 1`
done
