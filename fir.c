#include <stdio.h>

int koef[3] = {-1, 2, 3};

int data_out = 0;
int counter = 0;

void fir (int input)
{
    if (counter == 3)
        counter = 0;
    data_out = data_out + input*koef[counter];
    counter++;
}

int main()
{
    for (int data_in = -10; data_in <= 10; data_in++)
    {
        fir(data_in);
        printf("data_in = %d, data_out = %d\n", data_in, data_out);
    }
    return 0;
}