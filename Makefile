all:
	flex expr.l
	bison expr.y
	gcc -o compilador_floripa expr.c expr.tab.c

clean:
	rm expr.tab.c lex.yy.c compilador_floripa
