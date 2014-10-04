%{
/* Title: Word counting lexer
 Date: 28/09/2014 11:10AM
*/
int chrcnt=0;
int wordcnt=0;
int linecnt=0;

%}
word	[^ \t\n]+
line	[\n]
%%
{word}	{wordcnt++;chrcnt+=yyleng;}
{line}	{linecnt++;chrcnt+=1;}
.	{chrcnt++;}
%%
int main(int argc, char *argv[])
{
FILE *fp;
fp=fopen(argv[1],"r");
if(!fp)
{
	printf("File open Error\n");
	return(1);
}
yyin=fp;
yylex();
fclose(fp);
printf("Character Count : %d\n",chrcnt);
printf("Word Count : %d\n",wordcnt);
printf("Line Count : %d\n",linecnt);
return(0);
}
int yywrap()
{
/*This function will be called by lexer after End of stream occurs, file*/
return 1;
/*if you want to read more files just set yyin to next fp and return 0*/
}
