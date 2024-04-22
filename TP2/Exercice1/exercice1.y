%{
#include<stdio.h>
int yylex(void);
int yyerror(char *s);
int sum = 0;
int product = 1;
int sub = 0;
float divide = 0;
%}
%token FIN;
%token SOM;
%token PROD;
%token NB;
%token SUB;
%token DIV;

%%
liste: FIN
     | SOM listesom '.' { printf("Sum : %d\n", sum); sum = 0;} liste
     | PROD listeprod '.' { printf("Product: %d\n", product); product = 1; } liste ;
     | SUB listesub '.' { printf("soustraction: %d\n", sub); sub = 0; } liste ;
     | DIV listediv '.' { printf("division: %f\n", divide); divide = 0; } liste ;

listesom: NB { sum += $1; }
        | listesom ',' NB { sum += $3; };

listeprod: NB { product *= $1; }
         | listeprod ',' NB { product *= $3; };

listesub: NB { sub += $1; }
         | listesub ',' NB { sub -= $3; };

listediv: NB { divide = $1;}
         | listediv ',' NB { divide /=(float)$3;};

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