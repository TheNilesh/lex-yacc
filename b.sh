#Script to see output of lex and yacc
rm a.out
echo "lex and yacc output script for = " $1
lex $1l
yacc -d $1y
gcc lex.yy.c y.tab.c -ll
echo "./a.out"
./a.out
