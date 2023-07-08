%{
#include <stdio.h>
char num[26];
int string_index=0;
%}
%token TOK_SEMICOLON TOK_ADD TOK_SUB TOK_MUL TOK_DIV TOK_PRINTLN TOK_ID TOK_EQUAL INT FLOAT TOK_NUM TOK_FLOAT
 
/*all possible types*/
%union{
int int_val;
double float_val;
int int_num;
char string_val;
}

%type <int_val> TOK_NUM
%type <float_val> expr TOK_FLOAT
%type <string_val> TOK_ID
/*left associative*/
%left TOK_ADD TOK_SUB
%left TOK_MUL TOK_DIV
%right TOK_EQUAL
%%
start:
     %empty | start expr_stmt;
expr_stmt:
	 expr TOK_SEMICOLON
| TOK_PRINTLN expr TOK_SEMICOLON
{ fprintf(stdout, "the value is %lf\n", $2); };
expr: 
    expr TOK_ADD expr
{ $$ = $1 + $3;}
| expr TOK_SUB expr
{ $$ = $1 - $3; }
| expr TOK_MUL expr
{ $$ = $1 * $3; }
| expr TOK_DIV expr
{ $$ = $1 / $3; }
| TOK_NUM
{ $$ = $1; }
| TOK_ID TOK_EQUAL expr
{ num[string_index] = $3;printf("%d", num[string_index]); string_index++;}
| TOK_ID 
{ $$ = $1;}
| INT TOK_ID
{ printf("integer"); }
| FLOAT TOK_ID
{ printf("float"); }
| TOK_FLOAT
{ $$ = $1; }
;

%%
int yyerror() {
    fprintf(stderr, "syntax error\n");
    return 0;
}

int main() {
   if( yyparse()){
fprintf(stderr, "Successfull");}
    return 0;
}



