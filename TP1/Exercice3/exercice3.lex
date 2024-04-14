%%
[0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][ ][0-9][0-9] {fprintf(yyout,"telephone = %s\n",yytext);}
[a-z]([a-z]|[0-9]|[ ])+ {fprintf(yyout,"prenom = %s\n",yytext);}
[A-Z]([a-z]|[0-9])* {fprintf(yyout,"nom = %s\n",yytext);}
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