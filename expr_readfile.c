// Compilar com gcc -o expr lex.yy.c expr.tab.c 

#include <stdio.h>

extern FILE *yyin;

int main()
{	
	while(1){
		yyin = fopen("teste.txt","rt");
		if(yyin == NULL)
			printf("problemas no arquivo\n");
		yyparse();
	}
	fclose(yyin);
	return 0;
}

