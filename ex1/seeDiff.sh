for j in {0..10}
do
   diff -c ./Test$j\ */expOut.txt ./Test$j\ */out.txt
done