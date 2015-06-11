all:
	flex expr.l
	bison expr.y
	gcc -o compila expr.c expr.tab.c lista.c

clean:
	rm expr.tab.c lex.yy.c compila
