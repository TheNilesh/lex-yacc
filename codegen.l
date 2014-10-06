%{
/*Title: Code generation
  Time: 12:19 PM 5 OCT 14*/
#include<stdio.h>
#include "y.tab.h"
%}
asop	[=]
cmpop	==|<|<=|!=|>|>=
arth	[+|-|/|*]
dt	int|float|char
D	[0-9]
L	[a-zA-Z]
id	{L}({L}|{D})*
int	{D}+
%%
{dt} 	{printf("\n%s is Datatype",yytext); return DT;}
{id} 	{printf("\n%s is Identifier",yytext); return ID;}
{asop}	{printf("\nAssignment Operator"); return ASS;}
{cmpop} {printf("\n%s is Comparison Operator",yytext); return CMP;}
{int} 	{printf("\n%s is Integer",yytext); return NUMBER;}
{arth}	{printf("\n%s is arithmetic operator.",yytext); return ARTH;}
%%
int yywrap()
{
return 1;
}
