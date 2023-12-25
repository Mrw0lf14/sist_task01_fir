#include <stdio.h>
void complexMul(int ar, int ai, int br, int bi)
{
    int pr = ar*(br+bi)-(ar+ai)*bi;
    int pi = ar*(br+bi)+(ai-ar)*br;
    printf("%2d %2d %2d %2d %2d %2d\n", ar, ai, br, bi, pr, pi);
}
int main()
{
    printf("Ar Ai Br Bi Pr Pi\n");
    for (int ar = -1; ar < 2; ar++)
        for (int ai = -1; ai < 2; ai++)
            for (int br = -1; br < 2; br++)
                for (int bi = -1; bi < 2; bi++)
                    complexMul(ar, ai, br, bi);
    return 0;
}