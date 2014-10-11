#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include<stdlib.h>


struct expr
{
	char op,op1[5],op2[5],reg[5];
}*arr;

void input(int n)
{
	int i;
	arr=(struct expr*)malloc(sizeof(struct expr)*n);
	printf("\nEnter Following Information::\n");
	for(i=0;i<n;i++)
	{
		printf("\nOPERATOR:: ");
		scanf("%s",&arr[i].op);
		printf("\nOPERAND1:: ");
		scanf("%s",&arr[i].op1);		
		printf("\nOPERAND2:: ");
		scanf("%s",&arr[i].op2);
		printf("\nRESULT:: ");
		scanf("%s",&arr[i].reg);		
	}
}

/*int checkno(char temp[])
{
	int i;
	int len=strlen(temp);
	for(i=0;i<len;i++)
	if(isdigit(temp[i]==0))
	break;
	if(i==len)
	return(1);
	return(0);
}*/

int eval(int i)
{
	int op1,op2,tot;
	op1=atoi(arr[i].op1);
	op2=atoi(arr[i].op2);
	switch(arr[i].op)
	{
		case '+':
			tot=op1+op2;
			break;
		case '-':
			tot=op1-op2;
			break;
		case '*':
			tot=op1*op2;
			break;
		case '/':
			if(op2==0)
			{
				printf("Divide By Zero Error");
				exit(0);
			}
			tot=op1/op2;
			break;
	}
	arr[i].op='n';
	return(tot);
}

void subst(int id,int j,int n)
{
	int i;
	for(i=j+1;i<n;i++)
	{
		if(strcmp(arr[i].op1,arr[j].reg)==0)
		strcpy(arr[i].op1,arr[id].reg);
		if(strcmp(arr[i].op2,arr[j].reg)==0)
		strcpy(arr[i].op2,arr[id].op2);
		if(strcmp(arr[i].reg,arr[j].reg)==0)
		strcpy(arr[i].reg,arr[id].reg);
	}
	arr[j].op='n';
}

void csub(int n)
{
	int i,j;
	for(i=0;i<n;i++)
	{
		for(j=i+1;j<n;j++)
		{
			if(arr[i].op==arr[j].op)
			{
				if(strcmp(arr[i].op1,arr[j].op1)==0 && strcmp(arr[i].op2,arr[j].op2)==0 || strcmp(arr[i].op1,arr[j].op2)==0 && strcmp(arr[i].op2,arr[j].op1)==0)
				subst(i,j,n);
			}
		}
	}
}

void output(int n)
{
	int i;
	printf("\n\tOPERATOR\tOP1\tOP2\tRESULT");
	for(i=0;i<n;i++)
	{
		if(arr[i].op=='n')
		continue;
		if(arr[i].op=='\0')
		continue;
		printf("\n\t%c\t\t%s\t%s\t%s",arr[i].op,arr[i].op1,arr[i].op2,arr[i].reg);
	}
printf("\n");
}

void subst1(int id,int n,char reg[])
{
	int i;
	for(i=id+1;i<n;i++)
	{
		if(strcmp(arr[i].reg,arr[id].reg)==0)
		strcpy(arr[i].reg,reg);
		if(strcmp(arr[i].op1,arr[id].reg)==0)
		strcpy(arr[i].op1,reg);
		if(strcmp(arr[i].op2,arr[id].reg)==0)
		strcpy(arr[i].op2,reg);
	}
}

/*void ceval(int n)
{
	int i,tot;
	char array[10];
	for(i=0;i<n;i++)
	{
		if(checkno(arr[i].op1) && (checkno(arr[i].op2)))
		{
			tot=eval(i);
			//dtostr(tot);
			subst1(i,n,array);
		}
	}
}*/

main()
{
	int n,c;
	printf("\nProgram for Code Optimization\n");
	printf("---------------------------------");
	printf("\n1.Common SubExpression Elimination");
	/*printf("\n2.Constant Expression Evaluation");*/
	printf("\n3.Exit");
	printf("\n Enter Your Choice::");
	scanf("%d",&c);
	switch(c)
	{
		case 1:
			printf("\n Enter total number of Expression::");
			scanf("%d",&n);
			input(n);
			csub(n);
			output(n);
			break;
	/*	case 2:
			printf("\n Enter total number of Expression::");
			scanf("%d",&n);
			input(n);
			ceval(n);
			output(n);
			break;*/
		case 3:
			default:printf("\nInvalid Choice");
				exit(0);
	}
}
