#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define T_INT 1
#define T_STRING 2
#define T_NONE 3

typedef struct lista{
    struct lista *pxmo;
    int tipo;
    char id[256];
    int pos;
}Lista;

typedef struct{
    int tipo;
    char id[256];
    Lista *listaID;
} atributo;

Lista* iniciaLista(char* id);
Lista* insereLista(Lista* l, char* id);
void tabela(int tipo, Lista *l);
void print();
