%{
#include "y.tab.h"
%}
%%
[a-z]		{yylval.cval=yytext[0]; return VAR;}
[ \t]		;
\n		{return 0; /*this is to stop execution */ }
.		{return yytext[0];}
%%
int yywrap()
{
return 1;
}
