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
targetcode()
{//read q[] and convert to assembly
 int i,j=0,f=1; 
 char temp[10];
 int label[20];
 for(i=0;i<20;i++)
     label[i]=0;
 for(i=0;i<k;i++) //scan once to decide label
 {
   if(q[i].result[0]!='t')
	label[atoi(q[i].result[0])]=f++;
   else
	label[atoi(q[i].result[0])]=0;
 }

 for(i=0;i<k;i++)
 {
  if(label[i]!=0)
	printf("L%d :\n",label[i]);
  strcpy(temp,q[i].operator);
  if(strcmp("+",temp)==0)
	{
	    printf("MOV AX,%s\n",q[i].operand1);
	    printf("ADD AX,%s\n",q[i].operand2);
	    printf("MOV %s,AX\n",q[i].result);
	    j+=3;
	}
  else if(strcmp("++",temp)==0)
	{
	    printf("INC %s\n",q[i].operand1);
	    j++;
	}
  else if(strcmp("=",temp)==0)
	{
	    printf("MOV AX,%s\n",q[i].operand1);
	    printf("MOV %s,AX\n",q[i].result); j+=2;
	}
  else if(strcmp("if",temp)==0)
	{
	    printf("MOV AX,%s\n",q[i].operand1);
	    printf("JNZ L%d\n",label[atoi(q[i].result)]); j+=2;
	}
  else if(strcmp("goto",temp)==0)
	{
	    printf("JMP L%d\n",label[atoi(q[i].result)]); j++;
	}
 }//for

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
S: main	'\n'			{printic();printf("\n"); targetcode();}
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
