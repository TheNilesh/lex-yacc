%{
#include<stdio.h>
int v=0;
int c=0;
%}
%%
[aeiou]			{v++;}
[b-df-hj-np-tv-z]	{c++;}
%%
main(int argc, char *argv[])
{
	FILE *fp;
	fp=fopen(argv[1],"r");
	yyin=fp;
	yylex();
	fclose(fp);
	printf("Vowels=%d\nConsonants=%d\n",v,c);
}
int yywrap()
{
return 1;
}
