%{
#include<string.h>
#include<stdio.h>
#include<malloc.h>
static int k;	//current loc in tbl
static int t=0;	//temp var generator
static int jmp; //loc in tbl where goto oprnd is to be filled when block ends
int blkstart; //start location of loop
struct ic
{
	char operator[10];
	char operand1[10];
	char operand2[10];
	char result[10];
}q[20];	/*quadraple*/

void *putintab(char oprtr[],char oprnd1[], char oprnd2[])
{
	char *temp;
	temp=malloc(10*sizeof(char));
	strcpy(q[k].operator,oprtr);
	strcpy(q[k].operand1,oprnd1);
	strcpy(q[k].operand2,oprnd2);
	sprintf(temp,"t%d",t++);
	strcpy(q[k].result,temp);
	k++;
	return temp;
}
void *putintab2(char oprtr[],char oprnd1[], char res[]) //for oprtrs having 1 operand and result
{
	char *temp;
	temp=malloc(10*sizeof(char));
	strcpy(q[k].operator,oprtr);
	strcpy(q[k].operand1,oprnd1);
	strcpy(q[k].operand2," ");
	sprintf(temp,"%s",res);//ass op returns result
	strcpy(q[k].result,res);
	k++;
	return temp;
}
printic()
{
int i;
for(i=0;i<k;i++)
	printf("%2d %5s %5s %5s %5s\n",i, q[i].operator,q[i].operand1,q[i].operand2,q[i].result);
}
char *inttostr(int integer)
{
 char *temp=malloc(10*sizeof(char));
 sprintf(temp,"%d",integer);
 return temp;
}
void subst(int i,int j)
{
	int m;
	for(m=j+1;m<k;m++)
	{
		if(strcmp(q[m].operand1,q[j].result)==0)
			strcpy(q[m].operand1,q[i].result);
		if(strcmp(q[m].operand2,q[j].result)==0)
			strcpy(q[m].operand2,q[i].operand2);
		if(strcmp(q[m].result,q[j].result)==0)
			strcpy(q[m].result,q[i].result);
	}
	strcpy(q[j].operator,"n");
}

void csub()
{
	int i,j;
	for(i=0;i<k;i++)
	{
		for(j=i+1;j<k;j++)
		{
			if(strcpy(q[i].operator,q[j].operator))
			{
				if(strcmp(q[i].operand1,q[j].operand1)==0 && strcmp(q[i].operand2,q[j].operand2)==0 || strcmp(q[i].operand1,q[j].operand2)==0 && strcmp(q[i].operand2,q[j].operand1)==0)
				subst(i,j);
			}
		}
	}
}
%}
%union
{
	char cval[10];
}
%token IF ASSOP WHILE ELSE
%token <cval> VAR COP AOP UN
%type <cval> exp
%left '='
%left '+' '-'
%left '*' '/'
%left COP
%%
S: main	'\n'			{printic();csub();printf("opt\n");printic();}
;
main: ifstmt body exp_list
| exp_list
| whilestmt lbody exp_list
| ifstmt body elsestmt main
;
while: WHILE			{blkstart=k;}
;
else: ELSE			{strcpy(q[jmp].result,inttostr(k+1)); putintab2("goto"," "," "); jmp=k-1;}
;
whilestmt: while '(' exp ')'	{putintab2("if",$3,inttostr(k+2)); putintab2("goto"," "," "); jmp=k-1;}
;
ifstmt: IF '(' exp ')'  	{putintab2("if",$3,inttostr(k+2)); putintab2("goto"," "," "); jmp=k-1;}
;
elsestmt: else body
;
exp:VAR AOP exp			{strcpy($$,putintab($2,$1,$3));}
| VAR COP exp			{strcpy($$,putintab($2,$1,$3));}
| VAR ASSOP exp 		{strcpy($$,putintab2("=",$3,$1));}
| VAR UN			{strcpy($$,putintab2($2,$1,$1));}
| VAR
;
exp_list: exp ';' exp_list
|
;
body: '{' exp_list '}'		{strcpy(q[jmp].result,inttostr(k));}
;
lbody: '{' exp_list '}'		{strcpy(q[jmp].result,inttostr(k+1)); putintab2("goto"," ",inttostr(blkstart));}
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
