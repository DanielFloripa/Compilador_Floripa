#include <stdio.h>

extern FILE *yyin;

int main(int argv, char **argc){
	if (argv > 1){
		printf("Analisando o arquivo: %s\n",argc[1]);
		yyin = fopen(argc[1], "rt");	
		if (yyin == NULL)
			printf("Problemas no arquivo\n");
	}
	else{
		yyin = stdin;
		printf("Digite uma expressao:");
	}
	yyparse();
	fclose(yyin);
	return 0;
}

