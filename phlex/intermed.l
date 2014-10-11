%{

#include"y.tab.h"

%}

%%
[a-z]* { yylval.dval=yytext[0]; return CHAR; }
[\t ]   ;
\n     return 0;
.      {return yytext[0];}
%%
