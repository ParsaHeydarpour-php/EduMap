#include <stdio.h>

#define SIZE 8

void print_array(int arr[], int n) {
    for (int i = 0; i < n; i++)
        printf("%3d", arr[i]);
    printf("\n");
}

void bubble_sort(int arr[], int n) {
    for (int pass = 0; pass < n - 1; pass++) {
        int swapped = 0;

        for (int i = 0; i < n - 1 - pass; i++) {
            if (arr[i] > arr[i + 1]) {
                int tmp    = arr[i];
                arr[i]     = arr[i + 1];
                arr[i + 1] = tmp;
                swapped    = 1;
            }
        }

        printf("Pass %d: ", pass + 1);
        print_array(arr, n);

        /* early exit if already sorted */
        if (!swapped)
            break;
    }
}

int main(void) {
    int arr[SIZE] = {64, 25, 12, 22, 11, 90, 3, 47};

    printf("Bubble Sort\n");
    printf("-----------\n");
    printf("Start:  ");
    print_array(arr, SIZE);

    bubble_sort(arr, SIZE);

    printf("Result: ");
    print_array(arr, SIZE);

    return 0;
}
