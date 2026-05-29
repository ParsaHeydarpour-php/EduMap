#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;

    // Unsortierte Liste initialisieren
    printf("Anzahl der Elemente eingeben: ");
    scanf("%d", &n);

    // Mehr als 2 Elemente?
    if (n <= 2) {
        printf("Nicht genug Elemente (mind. 3 benoetigt).\n");
        return 0;
    }

    int *unsortiert = (int *)malloc(n * sizeof(int));

    printf("Elemente eingeben (nur nicht-negative ganze Zahlen):\n");
    for (int i = 0; i < n; i++) {
        printf("Element [%d]: ", i);
        scanf("%d", &unsortiert[i]);
    }

    // Maximalen Wert finden fuer die Groesse der sortierten Liste
    int max = unsortiert[0];
    for (int i = 1; i < n; i++) {
        if (unsortiert[i] > max)
            max = unsortiert[i];
    }

    // Sortierte Liste auf 0 setzen
    int *sortiert = (int *)calloc(max + 1, sizeof(int));

    // Fuer jedes Element (e) der unsortierten Liste:
    // Stelle e der sortierten Liste um 1 erhoehen
    for (int i = 0; i < n; i++) {
        sortiert[unsortiert[i]]++;
    }

    // Fuer jedes Element (e) der sortierten Liste:
    // Ausgabe von e mal dem aktuellen Index
    printf("\nSortierte Liste:\n");
    for (int index = 0; index <= max; index++) {
        int e = sortiert[index];
        for (int j = 0; j < e; j++) {
            printf("%d ", index);
        }
    }
    printf("\n");

    free(unsortiert);
    free(sortiert);

    return 0;
}
