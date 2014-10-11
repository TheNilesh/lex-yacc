%{

#include<stdio.h>

#include<string.h>

struct st

{

char LEXeme[25];

char name[25];

}ST[100];


int cnt=0;

%}

ID [a-zA-Z][a-zA-Z0-9]*

DIGIT [0-9]



%%

{DIGIT}+ {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"const integer literal");

cnt++;}


{DIGIT}+"."{DIGIT}+ {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"const float literal");

cnt++;}



"#include"|"#define" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"pp directive");cnt++;}

{ID}".h" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"include file");

cnt++;}


main|void|switch|case|continue|break|do|while|for|if|else|int|float|char {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"keyword");cnt++;}


"\""{ID}"\"" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"string literal");cnt++;}

{ID} {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"identifier");cnt++;}



"+"|"-"|"*"|"/"|"%" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Arithmetic OP");cnt++;}


"&"|"|"|"^"+"~" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Bitwise OP");cnt++;}


"<<"|">>" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Bitwise Shift OP");cnt++;}


"&&"|"||"|"!" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Logical OP");cnt++;}


"<"|">"|"<="|">=" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Relational OP");cnt++;}


"=="|"!=" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Equality OP");cnt++;}

"[" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"OSB");cnt++;}

"]" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"CSB");cnt++;}

"{" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"OCB");cnt++;}

"}" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"CCB");cnt++;}

"(" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"ORB");cnt++;}

")" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"CRB");cnt++;}

";" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Semicolon");cnt++;}

"++" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Inc OP");cnt++;}

"--" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Dec OP");cnt++;}

"?" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Ternary OP");cnt++;}

"=" {strcpy(ST[cnt].LEXeme,yytext);strcpy(ST[cnt].name,"Assignment OP");cnt++;}



%%



main(int argc,char *argv[])

{

int i=0;

yyin=fopen(argv[1],"r");

yylex();

printf("\nTOKEN TABLE");

printf("\nLEXEME\t\t\tNAME\n");

printf("___________\t\t_________________\n");

for(i=0;i<cnt;i++)

{

printf("\n%s",ST[i].LEXeme);

printf("\t\t\t%s",ST[i].name);

}


printf("\n");

}




// input

//File Name : subset_C.c

// Output


//[root@localhost ~]# LEX analyze.l

//[root@localhost ~]# cc LEX.yy.c -ll

//[root@localhost ~]# ./a.out subset_C.c




