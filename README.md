Repository of my lex and yacc programs.

How to run?

setup following:
0. sudo apt-get update
1. sudo apt-get install flex
2. sudo apt-get install bison
3. sudo apt-get git-core

Get this repo:
4. git clone https://github.com/TheniL/lex-yacc.git


Compile:
5. lex <filename.l>
6. yacc -d <filename.y>
7. gcc lex.yy.c y.tab.c -ll
    OR
5-7. ./outlex <filename>

Run:
8. ./a.out

*****OPTIMIZE SOURCE CODE*****

Save to github:
9. git commit -a -m "<Your savetag>"
10. git push
