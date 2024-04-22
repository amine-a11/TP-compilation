%{
#include<stdio.h>
int yylex(void);
int yyerror(char *s);
int sum = 0;
int product = 1;
%}
%token FIN;
%token SOM;
%token PROD;
%token NB;

%%
liste: FIN
     | SOM listesom '.' { printf("Sum before : %d\n", sum); sum = 0;} liste
     | PROD listeprod '.' { printf("Product: %d\n", product); product = 1; } liste ;

listesom: NB { sum += $1; }
        | listesom ',' NB { sum += $3; };

listeprod: NB { product *= $1; }
         | listeprod ',' NB { product *= $3; };
%%
#include "lex.yy.c"
int yyerror(char *s){
    printf("Error : %s\n",s);
    return 0;
}
int main(){
    yyparse();
    getchar();
    return 0;
}