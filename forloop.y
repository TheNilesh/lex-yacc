/* Title: For loop lexer
   Date: 3 Oct 2014
   Programmer: Nilesh Akhade
*/
%{
#include<stdio.h>
%}
%token FOR ID BOP UOP NUMBER
%%
prg: FOR '(' lexp ';' lexp ';' lexp ')' lbody {printf("Syntax Correct\n");}
;
lbody: stmt			/*body can be one stmt */
| block				/* body can be block */
| prg				/*body with nested for loop*/
;
block: '{' stmt_list '}'	/* block contains statements*/
|'{' prg '}'			/* Allow nested for loop/blocks */ 
;
stmt_list: stmt_list stmt	/*list of statements*/
|
;
stmt: lexp ';'			/*Statement ends with semicolon*/
;
lexp: fexp			/*expression does not ends with semi*/
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
