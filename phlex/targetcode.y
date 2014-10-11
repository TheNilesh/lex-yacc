%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

   static int i;
   int j=0;
   char temp;
   static char k='A';
   struct table{
	char op;
	char arg1;
	char arg2;
	int result;
	       }q[20];
char putintab(char opr,char a1,char a2)
{
	q[i].op=opr;
	q[i].arg1=a1;
	q[i].arg2=a2;
	q[i++].result=k;
	return k;
}

%}
%union{
	char dval;
      }

%token<dval> CHAR
%type <dval> expression
%left '='
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%

statement:expression {printf("\nop\targ1\targ2\tresult\n");
	for(j=0;j<i;j++)
	{
	  printf("%c  \t %c  \t  %c \t %c",q[j].op,q[j].arg1,q[j].arg2,q[j].result);
		switch(q[j].op)
		{

		   case '+':
		   printf("\t\t MOV %c,%c\n",q[j].result,q[j].arg1);
		   printf("\t\t\t\t\t ADD %c,%c\n",q[j].result,q[j].arg2);
		   break;

		   case '-':
		   printf("\t\t MOV %c,%c\n",q[j].result,q[j].arg1);
		   printf("\t\t\t\t\t SUB %c,%c\n",q[j].result,q[j].arg2);
		   break;

                   case '=':
                   printf("\t\t MOV %c,%c\n",q[j].result,q[j].arg1);
                   //printf("\t\t\t\t\t SUB %c,%c\n",q[j].result,q[j].arg2);
                   break;


		   case '*':
		   printf("\t\t MOV %c,%c\n",q[j].result,q[j].arg1);
		   printf("\t\t\t\t\t MUL %c,%c\n",q[j].result,q[j].arg2);
		   break;

		   case '/':
		   printf("\t\t MOV %c,%c\n",q[j].result,q[j].arg1);
 		   printf("\t\t\t\t\t DIV %c,%c\n",q[j].result,q[j].arg2);
		   break;

		   default:
		   printf(":-)");
		}
	}
  printf("\n");
};


expression:expression '+' expression{  $$=putintab('+',$1,$3);
					k++;
				    }

| expression '*' expression{  $$=putintab('*',$1,$3);
                                        k++;
                                    }

| expression '-' expression{  $$=putintab('-',$1,$3);
                                        k++;
                                    }
| expression '/' expression{  $$=putintab('/',$1,$3);
                                        k++;
                                    }

| CHAR '=' expression { q[i].op='=';
	q[i].arg1=$3;
	q[i++].result=$1;}

| '-' expression %prec  UMINUS { q[i].op= '-';
		q[i].arg1=$2;
	        q[i++].result=k;
		$$=k;
		k++;}
| '(' expression ')' {$$=$2;}

|CHAR {$$=$1; }
;

%%

main()
{
	yyparse();
}

yyerror(char *s)
{
	printf("%s",s);
	exit(0);
}




