#include <stdio.h>

int main() {
    int unsortiert[100];
    int sortiert[100];
    int n, i, j, max, e;

    // Unsortierte Liste initialisieren
    printf("Wie viele Zahlen? ");
    scanf("%d", &n);

    // Mehr als 2 Elemente?
    if (n <= 2) {
        printf("Bitte mindestens 3 Zahlen eingeben.\n");
        return 0;
    }

    printf("Zahlen eingeben:\n");
    for (i = 0; i < n; i++) {
        printf("Zahl %d: ", i + 1);
        scanf("%d", &unsortiert[i]);
    }

    // Groessten Wert finden
    max = unsortiert[0];
    for (i = 1; i < n; i++) {
        if (unsortiert[i] > max) {
            max = unsortiert[i];
        }
    }

    // Sortierte Liste auf 0 setzen
    for (i = 0; i <= max; i++) {
        sortiert[i] = 0;
    }

    // Fuer jedes Element (e) der unsortierten Liste:
    // Stelle e der sortierten Liste um 1 erhoehen
    for (i = 0; i < n; i++) {
        e = unsortiert[i];
        sortiert[e] = sortiert[e] + 1;
    }

    // Fuer jedes Element (e) der sortierten Liste:
    // Ausgabe von e mal dem aktuellen Index
    printf("\nSortierte Liste:\n");
    for (i = 0; i <= max; i++) {
        e = sortiert[i];
        for (j = 0; j < e; j++) {
            printf("%d ", i);
        }
    }
    printf("\n");

    return 0;
}
