%{
/*Title: scientific calc
Date : 30/09/2014*/
#include<stdio.h>
int flag=0;
float symtab[26];
float ans=0;
%}
%token NL
%token <ival> NUMBER ID
%type <ival> exp
%left '+' '-'
%left '*' '/'
%union
{
	float ival;
}
%%
stmt_list : stmt_list stmt NL
|
;
stmt : exp		{flag=1;printf("=%f",$1);}
| ID '=' exp		{symtab[(int)$1]=$3;}
;
exp : exp '+' exp	{$$=$1+$3;}
| '-' exp		{$$=-$2;}
| exp '-' exp		{$$=$1-$3;}
| exp '*' exp		{$$=$1*$3;}
| exp '/' exp		{$$=$1/$3;}
| '(' exp ')'		{$$=$2;}
| NUMBER
| ID			{$$=symtab[(int)$1];}
	;
%%
yyerror(char *s)
{
if(flag==0)
	printf("Invalid Expression\n");
}
main ()
{
printf("Enter the expression\n");
yyparse();
}
