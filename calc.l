%{
#include "y.tab.h"
extern YYSTYPE yylval;
%}
digit	[0-9]
dot	"."
id	[a-z]
%%
{digit}+({dot}{digit}+)*	{yylval.ival=atof(yytext); return NUMBER;}
{id}	{yylval.ival=*yytext-'a'; return ID;}
\n	{return NL;}
.	{return yytext[0];}
%%
