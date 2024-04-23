%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s);
int cpt = 0;
%}

%union {
    int entier;
    double reel;
    char* chaine;
}

%start query
%token SELECT FROM WHERE CREATE DELETE UPDATE ALL COMMA SEMICOLON TABLE DATATYPE OPENPAR CLOSEPAR OPTIONS SET BOOLEAN

%token <chaine> AND
%token <chaine> OR
%token <chaine> DIFF
%token <chaine> OPREL
%token <chaine> EQ
%token <chaine> NUMBER
%type <chaine> condition
%type <chaine> identifierOrNumber
%type <chaine> table_fields
%type <chaine> operator

%token <chaine> IDENTIFIER

%%

query: select_query | create_query | delete_query | update_query

select_query: SELECT ALL FROM IDENTIFIER SEMICOLON { printf("all elements from table %s are selected\n", $4); }
            | SELECT ALL FROM IDENTIFIER WHERE condition SEMICOLON { printf("all elements from table %s respecting this condition %s are selected\n", $4, $6); }
            | SELECT table_fields FROM IDENTIFIER SEMICOLON { printf("fields %s are selected from table %s\n", $2, $4);  printf("And you selected %d columns\n", cpt); cpt = 0;}
            | SELECT table_fields FROM IDENTIFIER WHERE condition SEMICOLON  { printf("fields %s from table %s which respect this condition %s are selected\n", $2, $4, $6); printf("And you selected %d columns\n", cpt); cpt = 0;}

create_query: CREATE TABLE IDENTIFIER OPENPAR fields CLOSEPAR SEMICOLON { printf("table %s created successfully !\n", $3); }

delete_query: DELETE FROM IDENTIFIER  SEMICOLON { printf("all elements from table %s are deleted\n", $3); }
            | DELETE FROM IDENTIFIER WHERE condition SEMICOLON { printf("all elements from table %s respecting this condition %s are deleted\n", $3, $5); }

update_query: UPDATE IDENTIFIER SET update_fields SEMICOLON { printf("table %s updated successfully\nAnd you updated %d columns", $2, cpt); cpt = 0;}
            

update_fields: IDENTIFIER EQ NUMBER { cpt++; } | IDENTIFIER EQ BOOLEAN  { cpt++; } | update_fields COMMA update_fields

fields: IDENTIFIER DATATYPE OPTIONS | fields COMMA fields | IDENTIFIER DATATYPE

table_fields: IDENTIFIER { $$ = strdup($1); cpt++;} | IDENTIFIER COMMA table_fields { $$ = strcat(strcat(strdup($1), ", "), $3); cpt++;}
condition: IDENTIFIER operator identifierOrNumber { $$ = strcat(strcat($1, $2), $3); } | condition AND condition { $$ = strcat(strcat($1, " AND "), $3); } | condition OR condition { $$ = strcat(strcat($1, " OR "), $3); }
operator: DIFF { $$ = strdup($1); } | OPREL { $$ = strdup($1); } | EQ { $$ = strdup($1); }
identifierOrNumber: IDENTIFIER { $$ = strdup($1); } | NUMBER { $$ = strdup($1); }
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: Unknown SQL Query !!\n");
}
#include "lex.yy.c"


int main(){
    yyparse();
    getchar();
    return 0;
}