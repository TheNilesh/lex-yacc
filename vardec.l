%{
/* Title : Variable Declaration
   Date : 10/10/2014
*/
#include "y.tab.h"
%}
D	[0-9]
num	{D}+
L	[a-z_A-Z]
id	{L}+({L}|{D})*
dt	int|float|double|char
op	"+"|"-"|"/"|"*"
%%
{dt}	{return DT;}
{op}	{return OP;}
[=]	{return ASSOP;}
[;]	{return SEMI;}
"["|"]"	{return yytext[0];}
"("|")"	{return yytext[0];}
"{"|"}"	{return yytext[0];}
","	{return *yytext;}
\n	{return *yytext;}
[ \t]	;
{num}	{return NUMBER;}
{id}	{return ID;}
%%
int yywrap()
{
return 1;
}
