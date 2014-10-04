#Script to see output of lex and yacc
echo "Doing all for = " $1
lex $1.l
yacc -d $1.y
gcc lex.yy.c y.tab.c -ll
echo "Now you can see output, if no errors are above. = ./a.out"
