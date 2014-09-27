%{
/* Nilesh Akhade
 * Prog #2 lex for C.
 * START:3:07 PM*/
%}

semi [;]
asop [=]
cmpop ==|<|<=|!=|>|>=
arth [+|-|/|*]
cnd if|else
dt int|float|char
inblt main|printf


D [0-9]+
L [a-z]+
id {L}({L}|{D})*


%%
{inblt} {printf("\n%s is inbuilt function",yytext);}

{dt} {printf("\n%s is Datatype",yytext);}

{id} {printf("\n%s is Identifier",yytext);}

{semi} {printf("\nsemicolon",yytext);}

{asop} {printf("\nAssignment Operator");}

{cmpop} {printf("\n%s is Comparison Operator",yytext);}

{D} {printf("\n%s is Number",yytext);}

{arth}	{printf("\n%s is arithmetic operator.",yytext);}

%%
main(void)
{
	FILE *fptr;
	char fname[50];
	printf("Enter filename: ");
	scanf("%s",fname);
	fptr=fopen(fname,"r");
	if(fptr!=NULL)
	{	yyin=fptr; yylex();
	}
	else
	{
		printf("Input file error.Enter input manually.");
		yylex();
	}

}
int yywrap()
{return 1;}
