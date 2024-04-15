create [C|c][R|r][E|e][A|a][T|t][E|e]
table [T|t][A|a][B|b][L|l][E|e]
identifier ([a-z]|[A-Z])([a-z]|[A-Z]|[0-9]|_)*
%%
{create} {fprintf(yyout,"%s\t\tCREATE\n",yytext);}
"PRIMARY"[[:space:]]+"KEY" {fprintf(yyout,"%s\t\tPRIMARY_KEY\n",yytext);}
{table} {fprintf(yyout,"%s\t\tTABLE\n",yytext);}
int|varchar|DATE {fprintf(yyout,"%s\t\tDATATYPE\n",yytext);}
[0-9]+ {fprintf(yyout,"%s\t\tNUMBER\n",yytext);}
{identifier} {fprintf(yyout,"%s\t\tIDENTIFIER\n",yytext);}
[(] {fprintf(yyout,"%s\t\t(\n",yytext);}
[)] {fprintf(yyout,"%s\t\t)\n",yytext);}
, {fprintf(yyout,"%s\t\tCOMMA\n",yytext);}
. {}

%%

int yywrap(){return 1;}
int main(int argc, char *argv[]){
    ++argv,--argc;
    if(argc>0){
        yyin = fopen(argv[0],"r");
        yyout = fopen("resultat.txt","w");
    }else{
        yyin = stdin;
        yyout = stdout;
    }
    yylex();
}