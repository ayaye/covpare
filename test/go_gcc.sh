#!/bin/bash
rm -f *.gc*
gcc hello.cc -fprofile-arcs -ftest-coverage -ohello


./hello
for file in *.gcda; do gcov -a -b -c ${file/d$/c$} 1>/dev/null ; done
python ../parse.py left hello.cc.gcov
rm -f *.gcda *.gcov

./hello mom dad
for file in *.gcda; do gcov -a -b -c ${file/d$/c$} 1>/dev/null ; done
python ../parse.py right hello.cc.gcov
rm -f *.gcda *.gcov

python ../compare.py left right --function-diff
python ../compare.py left right --call-diff
python ../compare.py left right --line-diff
