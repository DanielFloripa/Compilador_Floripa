%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
#define YYSTYPE2 struct atributo;
#define T_INT 1
#define T_STRING 2

struct atributo{
	 int tipo;
	 // Lista *listId;
	 char nomeId[9];
};

%}

%token ID LITERAL TNUM VOID INT STRING IF ELSE WHILE READ PRINT RETURN TADD TSUB TMUL TDIV RMEN RMAI RMENEQ RMAIEQ REQU RDIF LAND LOR LNOT TATRIB TPTOVRGL TVIRGULA TAPAR TFPAR TACHAVE TFCHAVE TFIM

%%
Linha :Programa TFIM {printf("Resultado:%lf\n", $1);exit(0);}
	; 
	
Programa: ListaFuncao BlocoPrincipal
	| BlocoPrincipal
	;

ListaFuncao: ListaFuncao Funcao
	| Funcao 
	;

Funcao: TipoRetorno ID TAPAR DeclParametros TFPAR BlocoPrincipal 
	| TipoRetorno ID TAPAR TFPAR BlocoPrincipal
	;
	
TipoRetorno: Tipo
	| VOID
	;
	
DeclParametros: DeclParametros TVIRGULA Parametro
	| Parametro
	;
	
Parametro: Tipo ID
	;
	
BlocoPrincipal: TACHAVE Declaracoes ListaCmd TFCHAVE
	| TACHAVE ListaCmd TFCHAVE
	;

Declaracoes: Declaracoes Declaracao
	| Declaracao
	;
	
Declaracao: Tipo ListaId TPTOVRGL
	;
	
Tipo: INT
	| STRING
	;
	
ListaId: ListaId TVIRGULA ID
	| ID
	;
	
Bloco: TACHAVE ListaCmd TFCHAVE
	;
	
ListaCmd: ListaCmd Comando
	| Comando
	;
	
Comando:  CmdSe 
	| CmdEnquanto 
	| CmdAtrib 
	| CmdEscrita 
	| CmdLeitura 
	| ChamadaFuncao 
	| Retorno 
	;
	
Retorno: RETURN Expr TPTOVRGL
	;

CmdSe: IF TAPAR ExprLogico TFPAR Bloco
	| IF TAPAR ExprLogico TFPAR Bloco ELSE Bloco
	;

CmdEnquanto: WHILE TAPAR ExprLogico TFPAR Bloco
	;
	
CmdAtrib: ID TATRIB Expr TPTOVRGL
	| ID TATRIB LITERAL TPTOVRGL
	;
	
CmdEscrita: PRINT TAPAR Expr TFPAR TPTOVRGL
	| PRINT TAPAR LITERAL TFPAR TPTOVRGL
	;

CmdLeitura: READ TAPAR ID TFPAR TPTOVRGL
	;

ChamadaFuncao: ID TAPAR ListaParametros TFPAR TPTOVRGL
	| ID TAPAR TFPAR TPTOVRGL
	;

ListaParametros: ListaParametros TVIRGULA Expr
	| Expr
	;
		
ExprLogico: ExprLogico LAND TermoLogico
	| ExprLogico LOR TermoLogico
	| TermoLogico
	;
	
TermoLogico: LNOT TermoLogico
	| FatorLogico
	;
	
FatorLogico: TAPAR ExprLogico TFPAR
	| ExprRelacional
	;
	
ExprRelacional: Expr RMENEQ  Expr {$$ = $1 <= $3;}
	| Expr RMAIEQ  Expr {$$ = $1 >= $3;}
	| Expr RMEN Expr {$$ = $1 < $3;}
	| Expr RMAI Expr {$$ = $1 > $3;}
	| Expr REQU  Expr {$$ = $1 == $3;}
	| Expr RDIF  Expr {$$ = $1 != $3;}
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
    extern int yylineno;
    extern char *yytext;

    printf("%s <- antes\nyytext -> %s\n", str, yytext);
    printf("linha: %d\n", yylineno);
} 		 

int yywrap()
{
	return 1;
}
