%{
/* Title: Variable declaration in C 
(supports complex declarations except pointers, float, and char)
   Programmer: Nilesh Akhade
*/
#include<stdio.h>
%}
%token ID NUMBER SEMI ASSOP DT OP
%%
S: stmt '\n'			{printf("Valid declaration\n"); return 0;}
;
stmt:DT id_list SEMI
;
id_list: id_list ',' id1 | id1		/*Comma separated ids*/
;
id1: ID '[' NUMBER ']' ASSOP '{' val_list '}'	/*Array init*/
| id						/*if not arr_init then check other*/
;
id: ID
| ID ASSOP exp				/*int x=2*(1-3) */
| ID ASSOP id				/* int x=y=3; */
| ID '[' NUMBER ']'			/*array size/index >=0*/
;
exp:'(' exp ')'				/*(5+2)*/
| ID OP exp				/*x+2*/
| val OP exp				/* 3+5 or 3 + x+2 or 3+ 4*x */
| val OP ID				/*5+x*/
| ID OP ID				/*x+y*/
| val					/*9*/
;
val: NUMBER
;
val_list: val_list ',' val | val
;
%%
int main()
{
	yyparse();
}
yyerror(char *s)
{
printf("syntax error\n");
}
