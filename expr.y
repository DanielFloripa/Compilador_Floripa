%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
#define YYSTYPE2 struct atributo //
#define TINT 1
#define TSTRING 2

struct atributo{
	 int tipo;
	 Lista *listId;
	 char nomeId[9];
}

%}

%token TADD TMUL TSUB TDIV LAND LOR LNOT RMEN RMAI RMENEQ RMAIEQ REQU RDIF TAPAR TFPAR TNUM TFIM

%%
Linha :Logico TFIM {printf("Resultado:%lf\n", $1);exit(0);}
	; 
	
Programa: LstFuncao BlcPrincipal
	| BlcPrincipal
	;

LstFuncao: LstFuncao Funcao
	| Funcao 
	;

Funcao: TipoRetorno ID 
	
Logico: Logico LAND TLogico {$$ = $1 && $3;}
	| Logico LOR TLogico {$$ = $1 || $3;}
	| TLogico
	;
	
TLogico: LNOT TLogico {$$ = !$2;}
	| TAPAR Logico TFPAR {$$ = $2;}
	| Relacional
	;
	
Relacional: Expr RMENEQ  Expr {$$ = $1 <= $3;}
	| Expr RMAIEQ  Expr {$$ = $1 >= $3;}
	| Expr RMEN Expr {$$ = $1 < $3;}
	| Expr RMAI Expr {$$ = $1 > $3;}
	| Expr REQU  Expr {$$ = $1 == $3;}
	| Expr RDIF  Expr {$$ = $1 != $3;}
	| Expr
	;
	
Expr: Expr TADD Termo {$$ = $1 + $3;}
	| Expr TSUB Termo {$$ = $1 - $3;}
	| Termo
	;
	
Termo: Termo TMUL Fator {$$ = $1 * $3;}
	| Termo TDIV Fator {$$ = $1 / $3;}
	| Fator
	;
	
Fator: TNUM 
	| TAPAR Expr TFPAR {$$ = $2;}
	| TSUB Fator {$$ = -$2;}
	| TADD Fator {$$ = +$2;}
	;
%%
#include "lex.yy.c"

int yyerror (char *str)
{
	printf("%s - antes %s\n", str, yytext);
} 		 

int yywrap()
{
	return 1;
	// e r l
}
