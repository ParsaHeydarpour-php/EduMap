#include <stdio.h>

#define SIZE 8

void print_array(int arr[], int n) {
    for (int i = 0; i < n; i++)
        printf("%3d", arr[i]);
    printf("\n");
}

void insertion_sort(int arr[], int n) {
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j   = i - 1;

        /* shift elements greater than key one position to the right */
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;

        printf("Step  %d: ", i);
        print_array(arr, n);
    }
}

int main(void) {
    int arr[SIZE] = {64, 25, 12, 22, 11, 90, 3, 47};

    printf("Insertion Sort\n");
    printf("--------------\n");
    printf("Start:   ");
    print_array(arr, SIZE);

    insertion_sort(arr, SIZE);

    printf("Result:  ");
    print_array(arr, SIZE);

    return 0;
}
