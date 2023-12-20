#include <stdio.h>

int koef[3] = {-1, 2, 3};

int data_out = 0;
int data[3] = {0};
int counter = 0;
void fir (int input)
{
    data[2] = data[1];                                                          //eq <=
    data[1] = data[0];                                                          //eq <=
    data[0] = input;                                                            //eq <=
    
    
    data_out = data[0]*koef[0] + data[1]*koef[1] + data[2]*koef[2];
    printf("data0 = %3d, data1 = %3d, data2 = %3d, data_out = %d\n", data[0], data[1], data[2], data_out);
    if (counter < 3)
        counter++;
    else
        counter = 0;
}

int main()
{
    printf("koef0 = %3d, koef1 = %3d, koef2 = %3d\n", koef[0], koef[1], koef[2]);
    for (int data_in = -10; data_in <= 10; data_in++)
    {
        fir(data_in);
    }
    fir(0);
    return 0;
}