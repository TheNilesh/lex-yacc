Repository of my lex and yacc programs.

How to run?

setup following:
 0. sudo apt-get update
 0. sudo apt-get install flex
 0. sudo apt-get install bison
 0. sudo apt-get git-core

Get this repo:
 0. git clone https://github.com/TheniLesh/lex-yacc.git


Compile:
 0. lex filename.l
 0. yacc -d filename.y
 0. gcc lex.yy.c y.tab.c -ll
    OR
 0. ./outlex filename

Run:
 0. ./a.out
