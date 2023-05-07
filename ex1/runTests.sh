#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

tmpRes=$(ls | grep tmpdir)
if [[ $tmpRes == "" ]]; then
	mkdir tmpdir
fi
PWD=$(pwd)
export TMPDIR="$PWD/tmpdir"

for i in {0..10}
do
   # valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=./Tests/valgrind-out$i.txt ./HackEnrollment -i ./Test$i\ */students.txt ./Test$i\ */courses.txt ./Test$i\ */hackers.txt ./Test$i\ */queues.txt ./Test$i\ */out.txt
   if [[ `valgrind --leak-check=full ./HackEnrollment -i ./Tests/Test$i\ */students.txt ./Tests/Test$i\ */courses.txt ./Tests/Test$i\ */hackers.txt ./Tests/Test$i\ */queues.txt ./Tests/Test$i\ */out.txt |& grep 'All heap blocks were freed -- no leaks are possible'` == "" ]]; then
	echo -e -n "Test number $i result: ${RED}leaked memory${NC}"
   else
	echo -e -n "Test number $i result: ${GREEN}didn't leak${NC}"
   fi
   
   res=$(diff ./Tests/Test$i\ */expOut.txt ./Tests/Test$i\ */out.txt)
   if [[ $res == "" ]]; then
	echo -e " and ${GREEN}passed${NC}"
   else
	echo -e " and ${RED}failed${NC}"
   fi
done

