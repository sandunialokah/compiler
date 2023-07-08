%{
#include <stdio.h>
#include "calc.tab.h"
%}
digit [0-9]
alpha [a-zA-Z]
%%
"printvar " { return(TOK_PRINTLN);}
"int " { return(INT); }
"float " { return(FLOAT); }
{alpha}({alpha}|{digit})* { sscanf(yytext, "%s", &(yylval.string_val)); return TOK_ID; }
{digit}+ { sscanf(yytext, "%d", &(yylval.int_val)); return TOK_NUM; }
{digit}+\.{digit}+ { sscanf(yytext, "%lf", &(yylval.float_val)); return TOK_FLOAT; }
";" { return(TOK_SEMICOLON); }
"+" { return(TOK_ADD); }
"=" { return(TOK_EQUAL); }
"-" { return(TOK_SUB); }
"*" { return(TOK_MUL); }
"/" { return(TOK_DIV); }
[\t\n]+ 
. {printf("Invalid character '%c'\n", yytext[0]);}
%%

int yywrap() { return 1; }
