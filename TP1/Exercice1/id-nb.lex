lettre [a-z]|[A-Z]
chiffre [0-9]
%%
{lettre}({lettre}|{chiffre})* {printf("id = [%s]\n",yytext);}
{chiffre}+ {printf("entier = [%s]\n",yytext);}
. {}
%%
int yywrap(){return 1;}
int main(){
    yylex();
}