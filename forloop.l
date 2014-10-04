%{
#include "y.tab.h"
%}
D	[0-9]
L	[a-zA-Z]
num	{D}+
id	{L}({D}|{L})*
cop	<|>|!=|<=|>=|==|=|"+"|"-"
uop	"++"|"--"
%%
"for"				{return FOR;}
{cop}				{return BOP;}
{uop}				{return UOP;}
{num}				{return NUMBER;}
{id}				{return ID;}
[ \n\t]				; /*reject whitespaces*/
.				{return *yytext;}
%%
int yywrap(){return 1;}
