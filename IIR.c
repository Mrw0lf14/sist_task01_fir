#include <stdio.h>

#define SIZE 15

static int kx = 5;
static int ky = 1;

void iir(int* x, int* y, int size)
{
    for (int i = 0; i < SIZE; i++)
    {
        y[i] = kx*x[i] + ky*(i>0?y[i-1]:0);
    }
}

void printXY(int* f, int size)
{
    for (int i = 0; i < size; i++)
    {
        printf("%3d, ", f[i]);
    }
    printf("\n");
}

int main()
{
    int x[SIZE];
    int y[SIZE];

    x[1] = 1;
    iir(x, y, SIZE);
    
    printf("Импульсная характеристика:\n");
    printXY(x, SIZE);
    printXY(y, SIZE);
    
    for (int i = 0, j = -SIZE/2; i < SIZE; i++, j++)
    {
        x[i] = j;
    }
    iir(x, y, SIZE);
    
    printf("Произвольный сигнал:\n");
    printXY(x, SIZE);
    printXY(y, SIZE);
    
    return 0;
}