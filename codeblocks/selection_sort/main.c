#include <stdio.h>

#define SIZE 8

void print_array(int arr[], int n) {
    for (int i = 0; i < n; i++)
        printf("%3d", arr[i]);
    printf("\n");
}

void selection_sort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        /* find index of the minimum in the unsorted portion */
        int min_idx = i;
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[min_idx])
                min_idx = j;
        }

        /* swap minimum into its sorted position */
        if (min_idx != i) {
            int tmp        = arr[i];
            arr[i]         = arr[min_idx];
            arr[min_idx]   = tmp;
        }

        printf("Step  %d: ", i + 1);
        print_array(arr, n);
    }
}

int main(void) {
    int arr[SIZE] = {64, 25, 12, 22, 11, 90, 3, 47};

    printf("Selection Sort\n");
    printf("--------------\n");
    printf("Start:   ");
    print_array(arr, SIZE);

    selection_sort(arr, SIZE);

    printf("Result:  ");
    print_array(arr, SIZE);

    return 0;
}
