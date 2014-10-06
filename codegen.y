%{
#include<stdio.h>
%}
%token DT ID ASS CMP ARTH NUMBER SEMI
%%
exp: DT ID	{printf("hhgghg");}
;
%%
int main()
{
yyparse();
return 0;
}
yyerror(char *s)
{
printf("error");
}
