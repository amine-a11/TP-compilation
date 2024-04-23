%{
int line_number = 1;
%}
%%
\#.* {fprintf(yyout,"commentaire : %s\n",yytext);}
[0-9]+ { fprintf(yyout,"ENTIER : %s\n", yytext); }
[0-9]+"."[0-9]+ { fprintf(yyout,"REEL : %s\n", yytext); }
if|else|while {fprintf(yyout,"MOTCLE : %s\n", yytext);}
[a-zA-Z_][a-zA-Z0-9_]* { fprintf(yyout,"IDENT : %s\n", yytext); }
[+\-*\/] { fprintf(yyout,"OP-ARTHM : %s\n", yytext); }
= { fprintf(yyout,"AFFECT : %s\n", yytext); }
[<|>|<=|>=|==|!=] { fprintf(yyout,"OP-REL : %s\n", yytext); }
\"[^\"\n]*\" { fprintf(yyout,"CHAINE : %s\n", yytext); }
\n { line_number++; }
[ \t]+ ;
. { fprintf(yyout,"Erreur: ligne %d, caractère inattendu: %s\n", line_number, yytext); }
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