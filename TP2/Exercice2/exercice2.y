%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *s);
%}

%start query
%token CREATE TABLE ID LPAREN RPAREN TYPE_INT TYPE_VARCHAR TYPE_DATE INT PK
%token COMMA SEMICOLON


%%

query: CREATE TABLE ID LPAREN fields RPAREN SEMICOLON {
    printf("Requête SQL valide\n");
}
;

fields: field
    | fields COMMA field;

field: ID TYPE_VARCHAR LPAREN INT RPAREN pk_opt
        |ID TYPE_INT pk_opt
        |ID TYPE_DATE pk_opt
        ;
pk_opt: | PK;

%%
#include "lex.yy.c"
void yyerror(const char *s) {
    fprintf(stderr, "Erreur : %s\n", s);
}

int main(){
    yyparse();
    getchar();
    return 0;
}