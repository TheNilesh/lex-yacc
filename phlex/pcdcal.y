

 /*     
        TOPIC :-CALCULATOR USING LEX AND YACC */
                                                                                
                                                                                                                             
                                                                                                                             
%{
        #include<stdio.h>
        #include<math.h>
        #include<string.h>
        int no;
        int no1;
        char ch[10];
        int val=1;
        double temp,temp1;
%}
%token NUMBER
%left '-' '+'
%left '*' '/'
%right '^'
%nonassoc UMINUS
                                                                                                                             
%%
                                                                                                                             
statement:      expression              { printf("= %d\n", $1); }
        ;
                                                                                                                             
expression:     expression '+' expression { $$ = $1 + $3; }
        |       expression '-' expression { $$ = $1 - $3; }
        |       expression '*' expression { $$ = $1 * $3; }
        |       expression '/' expression
                                {       if($3 == 0)
                                                yyerror("divide by zero");
                                        else
                                                $$ = $1 / $3;
                                }
        |       '-' expression %prec UMINUS     { $$ = -$2; }
        |       '(' expression ')'      { $$ = $2; }
        |       expression '^' NUMBER   {
                                        if($3!=0)
                                                $$ = powre($1,$3);
                                        }
        |       NUMBER                  { $$ = $1; }
        ;
%%
                                                                                                                             
main()
{
        yyparse();
}
                                                                                                                             
yyerror(const char * msg)
{
        printf("Error!!!!!!!%s",msg);
}
powre(int no1,int no)
{
        while(no>0)
        {
                val = val * no1;
                no--;
        }
                                                                                                                             
        return val;
}


                                                                                










































