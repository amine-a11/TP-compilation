%{
#include <stdio.h>
#include "exercice2.tab.h"
%}


create [C|c][R|r][E|e][A|a][T|t][E|e]
table [T|t][A|a][B|b][L|l][E|e]
identifier ([a-z]|[A-Z])([a-z]|[A-Z]|[0-9]|_)*

%%


{create} {return CREATE;}
"PRIMARY"[[:space:]]+"KEY" {return PK;}
{table} {return TABLE;}
"int" {return TYPE_INT;}
"varchar" {return TYPE_VARCHAR;}
"DATE" {return TYPE_DATE;}
[0-9]+ {return INT;}
{identifier} {return ID;}
[(] {return LPAREN;}
[)] {return RPAREN;}
[,] {return COMMA;}
[;] {return SEMICOLON;}
[ \t\n]+                ; // Ignorer les espaces, tabulations et sauts de ligne
.                       { fprintf(stderr, "Caractère non reconnu : %s\n", yytext); }


%%

int yywrap() {
    return 1;
}
