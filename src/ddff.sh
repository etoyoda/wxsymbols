#!/bin/sh

cd $(dirname $0)

dd=1
while expr $dd '<=' 36 >/dev/null
do
  ff=5
  while expr $ff '<=' 45 >/dev/null
  do
    ruby -I. ddff-windbarb.rb $dd $ff ../img/d${dd}f${ff}.png
    ff=`expr $ff + 5`
  done
  dd=`expr $dd + 1`
done
