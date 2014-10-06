%{
#include<stdio.h>
%}
%token DT ID ASS CMP ARTH NUMBER
%%
codeline: DT ID			{printf("variable declared");}
|DT ID ASS exp
;
%%
int main()
{
yyparse();
return 0;
}
yyerror(char *s)
{}
