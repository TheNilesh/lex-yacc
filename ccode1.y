%{
#include<stdio.h>
%}
%token FOR ID BOP UOP NUMBER
%%
stmt_list: stmt_list stmt
|
;
stmt: lexp ';'
;
lexp: fexp			/* exp that does not ends with semi*/
|
;
fexp: fexp ',' exp		/*comma separated exp*/
|exp
|'(' fexp ')'			/*use braces for prio*/
;
exp: ID BOP exp			/*binary operator in the middle*/
| ID UOP			/*Unary operator at right*/
| UOP ID
| ID
| NUMBER
;
%%
main()
{
yyparse();
}
yyerror(char *s)
{
printf("error");
}
