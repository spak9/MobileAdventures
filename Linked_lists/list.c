/*****************************************************************************
*                                                                            *
*  -------------------------------- list.c --------------------------------  *
*                                                                            *
*****************************************************************************/

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include "list.h"


static void print_list(const List *list) {

ListElmt           *element;

int                *data,
                   i;

/*****************************************************************************
*                                                                            *
*  Display the linked list.                                                  *
*                                                                            *
*****************************************************************************/

fprintf(stdout, "List size is %d\n", list_size(list));

i = 0;
element = list_head(list);

while (1) {

   data = list_data(element);
   fprintf(stdout, "list[%03d]=%03d\n", i, *data);

   i++;

   if (list_is_tail(element))
      break;
   else
      element = list_next(element);

}

return;

}



/*****************************************************************************
*                                                                            *
*  ------------------------------- list_init ------------------------------  *
*                                                                            *
*****************************************************************************/
void list_init(List *list, void (*destroy)(void *data))
{
    list->size = 0;
    list->destroy = destroy;
    list->head = NULL;
    list->tail = NULL;

    return ;
}

/*****************************************************************************
*                                                                            *
*  ----------------------------- list_destroy -----------------------------  *
*                                                                            *
*****************************************************************************/
/*void list_destroy(List *list) 
{

    void *data;

    while (list_size(list) > 0) {
        // if elements exist in the list, remove the head 
        if (list_rem_next(list, NULL, (void **)&data) == 0 && 
            list->destroy != NULL) {
            // user defined function for freeing 'data' memory
            list->destroy(data);
        }
    }

    return;
}
*/

/* 
 * list_ins_next() *
 */
int list_ins_next(List *list, ListElmt *element, const void *data) {
    ListElmt *new_element;

    // Allocate space for new ListElem
    new_element = (ListElmt *) malloc(sizeof(ListElmt));
    if (new_element == NULL) {
        return -1;
    }

    // setup new element
    new_element->data = (void *)data;
    // case 1: element is NULL
    if (element == NULL) {
       
        // check if list is empty
        if (list_size(list) == 0) {
            list->tail = new_element;
        }
        // make new_element's next point to current head
        new_element->next = list->head;
        list->head  = new_element;
    } 
    // case 2: insert after elem
    else {
        if (element == list_tail(list)){
            list->tail = new_element;
        }
        element->next = new_element;
    }

    list->size++;

    return 0;
}

/*
 * list_rem_next()
 */
int list_rem_next(List* list, ListElmt* element, void** data) {
    
    ListElmt* old_element;
    // don't allow removal from empty list
    if (list_size(list) == 0) {
        return -1;
    }

    // remove head
    if (element == NULL) {
        *data = list->head->data;
        old_element = list->head;
        list->head = list->head->next; 

        // list is size 1, therefore head == tail
        if (list_size(list) == 1) {
            list->tail = NULL; 
        }
    }

    // middle or end node
    else {
        // can't remove non-existant node
        if (element->next == NULL) {
            return -1;
        }

        *data = element->next->data;
        old_element = element->next;
        element->next = element->next->next;

        // new tail
        if (element->next == NULL) {
            list->tail = element;
        }
    }

    // free allocated space of removed node
    free(old_element);

    list->size -= 1;

    return 0;
    
}



/* Main Testing */
int main() {
    List list;

    list_init(&list, free);    

    ListElmt e;
    int *data ;
    int i;
    
    printf("Testing list_ins_next()\n");
    for (i = 10; i > 0; i--) {

       if ((data = (int *)malloc(sizeof(int))) == NULL)
           return 1;
        *data = i;

    if (list_ins_next(&list, NULL, data) != 0)
       return 1;

    }
    print_list(&list);

    printf("Testing list_rem_next()\n - removing head (001), middle (005), and tail(10)\n");
    ListElmt* n1 = list_head(&list);
    ListElmt* n2 = n1->next->next->next;
    list_rem_next(&list, NULL,(void**) &data);
    list_rem_next(&list, n2, (void**) &data);
    print_list(&list); 

}










