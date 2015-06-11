%{
#include <stdio.h>
#include <stdlib.h>
#include "lista.h"
#define YYSTYPE atributo

%}

%token ID LITERAL TNUM VOID INT STRING IF ELSE WHILE READ PRINT RETURN TADD TSUB TMUL TDIV RMEN RMAI RMENEQ RMAIEQ REQU RDIF LAND LOR LNOT TATRIB TPTOVRGL TVIRGULA TAPAR TFPAR TACHAVE TFCHAVE TFIM

%%
Linha :Programa TFIM {print(); exit(0);}
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
	
Declaracao: Tipo ListaId TPTOVRGL {tabela($1.tipo, $2.listaID);}
	;
	
Tipo: INT {$$.tipo = T_INT;}
	| STRING {$$.tipo = T_STRING;}
	;
	
ListaId: ID {$$.listaID = iniciaLista($1.id);}
	| ListaId TVIRGULA ID {$$.listaID = insereLista($$.listaID, $3.id);}
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
	
ExprRelacional: Expr RMENEQ  Expr 
	| Expr RMAIEQ  Expr
	| Expr RMEN Expr
	| Expr RMAI Expr
	| Expr REQU  Expr
	| Expr RDIF  Expr
	;
	
Expr: Expr TADD Termo
	| Expr TSUB Termo 
	| Termo
	;
	
Termo: Termo TMUL Fator
	| Termo TDIV Fator
	| Fator
	;
	
Fator: TNUM 
	| TAPAR Expr TFPAR
	| TSUB Fator
	| TADD Fator
	;
%%
#include "lex.yy.c"

int yyerror (char *str)
{
    extern int yylineno;
    extern char *yytext;
    printf("%s <- antes\nyytex -> %s\n", str, yytext);
    printf("linha: %d\n", yylineno);
}

int yywrap()
{
    return 1;
}
