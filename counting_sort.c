#include <stdio.h>

int main()
{
    int unsortiert[100];
    int sortiert[100];
    int n, i, j, max, e;

    printf("Wie viele Zahlen moechtest du sortieren? ");
    scanf("%d", &n);

    // Mehr als 1 Element?
    if (n <= 1)
    {
        printf("Zu wenig Elemente!\n");
        return 0;
    }

    printf("Bitte die Zahlen eingeben:\n");
    for (i = 0; i < n; i++)
    {
        printf("Zahl %d: ", i + 1);
        scanf("%d", &unsortiert[i]);
    }

    // groessten Wert herausfinden
    max = unsortiert[0];
    for (i = 0; i < n; i++)
    {
        if (unsortiert[i] > max)
        {
            max = unsortiert[i];
        }
    }

    // Sortierte Liste auf 0 setzen
    for (i = 0; i <= max; i++)
    {
        sortiert[i] = 0;
    }

    // Fuer jedes Element (e) der unsortierten Liste:
    // Stelle e der sortierten Liste um 1 erhoehen
    for (i = 0; i < n; i++)
    {
        e = unsortiert[i];
        sortiert[e] = sortiert[e] + 1;
    }

    // Fuer jedes Element (e) der sortierten Liste:
    // Ausgabe von e mal dem aktuellen Index
    printf("\nErgebnis (sortiert):\n");
    for (i = 0; i <= max; i++)
    {
        e = sortiert[i];
        for (j = 0; j < e; j++)
        {
            printf("%d ", i);
        }
    }
    printf("\n");

    return 0;
}
