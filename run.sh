#!/bin/bash

rm lex.yy.c expr.output expr.tab.c expr

flex expr.l
bison expr.y
gcc -o expr expr.c expr.tab.c
./expr
