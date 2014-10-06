%{
/*Title: Code generation
  Time: 12:19 PM 5 OCT 14*/
#include<stdio.h>
#include "y.tab.h"
%}
asop	[=]
semi	[;]
cmpop	==|<|<=|!=|>|>=
arth	[+|-|/|*]
dt	int|float|char
D	[0-9]
L	[a-zA-Z]
id	{L}({L}|{D})*
int	{D}+
%%
{dt} 	{return DT;}
{id} 	{return ID;}
{asop}	{return ASS;}
{cmpop} {return CMP;}
{int} 	{return NUMBER;}
{arth}	{return ARTH;}
{semi}	{return SEMI;}
[ \t\n]	;
.	{return yytext[0];}
%%
int yywrap()
{
return 1;
}
