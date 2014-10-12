%{
#include "y.tab.h"
extern char *temp;
%}
%%
"if"		{return IF;}
"else"		{return ELSE;}
"while"		{return WHILE;}
"++"|"--"	{strcpy(yylval.cval,yytext); return UN;}
[=]		{return ASSOP;}
"<"|">"|"<="|">=" {strcpy(yylval.cval,yytext); return COP;}
"+"|"-"|"/"|"*" {strcpy(yylval.cval,yytext); return AOP;}
[(){};]		{return *yytext;}
[a-z]+		{strcpy(yylval.cval,yytext); return VAR;}
[ \t]		;
\n		{return *yytext;/*this is to stop execution */ }
.		{return *yytext;}
%%
int yywrap()
{
return 1;
}
