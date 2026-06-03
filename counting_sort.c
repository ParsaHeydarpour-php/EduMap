#include <stdio.h>

int main()
{
    int liste[10] = {5, 3, 8, 1, 9, 2, 7, 4, 6, 3};
    int zaehler[100];
    int i, j, groesster, anzahl;

    anzahl = 10;

    printf("Meine Liste:\n");
    for (i = 0; i < anzahl; i++)
    {
        printf("%d ", liste[i]);
    }
    printf("\n");

    // groessten Wert finden
    groesster = liste[0];
    for (i = 0; i < anzahl; i++)
    {
        if (liste[i] > groesster)
        {
            groesster = liste[i];
        }
    }

    // zaehler auf 0 setzen
    for (i = 0; i <= groesster; i++)
    {
        zaehler[i] = 0;
    }

    // zaehlen wie oft jede Zahl vorkommt
    for (i = 0; i < anzahl; i++)
    {
        zaehler[liste[i]] = zaehler[liste[i]] + 1;
    }

    // sortiert ausgeben
    printf("\nSortiert:\n");
    for (i = 0; i <= groesster; i++)
    {
        for (j = 0; j < zaehler[i]; j++)
        {
            printf("%d ", i);
        }
    }
    printf("\n");

    return 0;
}
