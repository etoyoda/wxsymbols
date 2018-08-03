for n in 0 1 2 3 4 5 6 7 8 9 nil auto
do
  ruby -I. n-cloud.rb $n ../img/n${n}.png
done
