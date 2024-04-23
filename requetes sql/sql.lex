%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sql.tab.h"
%}

%%

SELECT          { return SELECT; }
FROM            { return FROM; }
WHERE           { return WHERE; }
CREATE          { return CREATE; }
DELETE          { return DELETE; }
UPDATE          { return UPDATE; }
TABLE           { return TABLE; }
SET             { return SET; }

AND             { yylval.chaine = strdup(yytext); return AND; }
OR              { yylval.chaine = strdup(yytext); return OR; }
"*"             { return ALL; }

"INT"|"VARCHAR("([0-9]+)")"|"BOOL" { return DATATYPE; }
"NOT NULL"|"UNIQUE"|"PRIMARY KEY" { return OPTIONS; }


"TRUE"|"FALSE" { return BOOLEAN; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.chaine = strdup(yytext); return IDENTIFIER; }
[0-9]+          { yylval.chaine = strdup(yytext); return NUMBER; }

"="             { yylval.chaine = strdup(yytext); return EQ; }
","             { yylval.chaine = strdup(yytext); return COMMA; }
";"             { yylval.chaine = strdup(yytext); return SEMICOLON; }
"("             { yylval.chaine = strdup(yytext); return OPENPAR; }
")"             { yylval.chaine = strdup(yytext); return CLOSEPAR; }

"<="            { yylval.chaine = strdup(yytext); return OPREL; }
">="            { yylval.chaine = strdup(yytext); return OPREL; }
"<"             { yylval.chaine = strdup(yytext); return OPREL; }
">"             { yylval.chaine = strdup(yytext); return OPREL; }
"!="            { yylval.chaine = strdup(yytext); return DIFF; }
" " ;
.               { fprintf(stderr, "Error: Unrecognized character '%s'\n", yytext); }
                /* You can customize this error handling as needed */
                /* To tokenize unrecognized characters, you can add a return statement with a unique token */
                /* return UNRECOGNIZED; */

%%

int yywrap() {
    return 1;
}
