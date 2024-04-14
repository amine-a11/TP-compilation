%{
int nombre_de_mots=0,nombre_de_ligne=0,nombre_de_caracteres=0,somme_des_nombres=0;
%}
lettre [a-z]|[A-Z]
chiffre [0-9]
%%
{lettre}+ {nombre_de_mots++;nombre_de_caracteres+=strlen(yytext);}
{chiffre}+ {somme_des_nombres+=atoi(yytext);}
[\n] {nombre_de_ligne++;}
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
    fprintf(yyout,"nombre de mots = %d\n",nombre_de_mots);
    fprintf(yyout,"nombre de ligne = %d\n",nombre_de_ligne+1);
    fprintf(yyout,"nombre de caracteres = %d\n",nombre_de_caracteres);
    fprintf(yyout,"somme des nombres lus = %d\n",somme_des_nombres);
}