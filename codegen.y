%{
#include<stdio.h>
static int i;/*points to three adr code table loc*/ 
static char tvar='A'; //temporary variable
struct ic
{
	char operator;
	char operand1;
	char operand2;
	char result;
}code[20];	/*an instance*/

char putintab(char oprtr,char oprnd1,char oprnd2)
{
/* the quadraple */
	code[i].operator=oprtr;
	code[i].operand1=oprnd1;
	code[i].operand2=oprnd2;
	code[i++].result=tvar;
	return tvar; //value to push onto stack = $$
}
void printic()
{
int a;
  printf("Operator Operand1 Operand2 Result\n");
  for(a=0;a<i;a++)
	printf("%7c%7c%7c%7c\n",code[a].operator,code[a].operand1,code[a].operand2,code[a].result);
}
%}
%union
{
	char cval;
}
%token <cval> VAR
%type <cval> exp
%left '='
%left '+' '-'
%left '*' '/'
%%
stmt: exp	{printic();}
;
exp:exp '*' exp	{$$=putintab('*',$1,$3);tvar++;}
| exp '/' exp	{$$=putintab('/',$1,$3);tvar++;}
| exp '+' exp	{$$=putintab('+',$1,$3);tvar++;}
| exp '-' exp	{$$=putintab('-',$1,$3);tvar++;}
| exp '=' exp	{ code[i].result=$1;
		  code[i].operator='=';  /*ass has one oprnd only*/
		  code[i].operand1=$3;
		  code[i++].operand2=' ';
		  $$=$1; }
| VAR		{$$=$1;}
;
%%
main()
{
yyparse();
}
yyerror(char *s)
{
printf("%s\n",s);
}
