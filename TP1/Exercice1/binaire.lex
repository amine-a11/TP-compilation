%%
(0|1)+ fprintf(yyout,"c'est un nombre binaire");
.* fprintf(yyout,"ce n'est pas un nombre binaire");

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