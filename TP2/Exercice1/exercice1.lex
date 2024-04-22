%{
#include<stdio.h>
#include<math.h>
#include "exercice1.tab.h"
%}
%%
[0-9]+ {yylval=atoi(yytext);return NB;}
produit {return PROD;}
somme {return SOM;}
soustraction {return SUB;}
division {return DIV;}
[,|.] {return yytext[0];}
[$] {return FIN;}
[ \t\n] {}
. {printf("Erreur\n");}
%%
int yywrap(){return 1;}