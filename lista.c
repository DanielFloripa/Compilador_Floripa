#include <stdlib.h>
#include <stdio.h>
#include <string.h>


#include "lista.h"

Lista* s = NULL;

Lista* iniciaLista(char *id){
    Lista *l = (Lista*) malloc (sizeof(Lista));
    l->tipo = T_NONE;
    l->pxmo = NULL;
    l->pos = -1;
    strcpy(l->id, id);

    return l;
}

Lista* insereLista(Lista *l, char *id){
    if (l == NULL){
        //fprintf(stderr, "Error\n");
        return NULL;
    } else {
        Lista *aux = l;
        while (aux->pxmo != NULL){
            aux = aux->pxmo;
        }
        
        Lista *px = (Lista*) malloc (sizeof(Lista));
        px->tipo = T_NONE;
        px->pxmo = NULL;
        px->pos = -1;
        
        aux->pxmo = px; // ver se nao eh trocado
        strcpy(px->id, id);

        return l;
    }
}

void tabela(int tipo, Lista *l){

    if (s == NULL){
        Lista *tab = (Lista*) malloc (sizeof(Lista));
        tab->pxmo = NULL;
        s = tab;
    }

    Lista *aux = l;
    Lista *tab_pointer = s;

    while(tab_pointer->pxmo != NULL){
        tab_pointer = tab_pointer->pxmo;
    }

    tab_pointer->pxmo = aux;
    tab_pointer->tipo = tipo;

    while(tab_pointer->pxmo != NULL){
        tab_pointer = tab_pointer->pxmo;
        tab_pointer->tipo = tipo;
    }
}

void print(){
    Lista *aux = s->pxmo;

    static int a=0;
    a++;

    while (aux !=NULL){
        printf("%d Id = %s \t tipo = %s \n",a,  aux->id, aux->tipo == T_INT ? "INT" : "STRING");

        aux = aux->pxmo;
    }
}
