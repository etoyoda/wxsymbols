#!/bin/sh

cd $(dirname $0)

for dd in nil 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 \
  19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
do
  ff=5
  while expr $ff '<=' 100 >/dev/null
  do
    ruby -I. ddff-windbarb.rb $dd $ff ../img/d${dd}f${ff}.png
    ff=`expr $ff + 5`
  done
  for ff in 110 120 130 140 150 200
  do
    ruby -I. ddff-windbarb.rb $dd $ff ../img/d${dd}f${ff}.png
  done
  ruby -I. ddff-windbarb.rb $dd nil ../img/d${dd}fnil.png
done
ruby -I. ddff-windbarb.rb 0 0 ../img/d0f0.png
