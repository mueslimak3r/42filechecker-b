#include <stdio.h>
#include <assert.h>
#include <limits.h>


int			main(void)
{
	int  max = INT_MAX;
	int  min = INT_MIN;
	int  zero = 0;
	char str[] = "abcdefghijklmnopqrstuwxyz";
	/*int  i = 0;

	while (i < 50)
	{
		//printf("%d %s\n", i, &str[i % 26]);
		//printf("%d %s\n", i, &str[i % 26]);
		//b_printf("%d %s\n", i, &str[i % 26]);
        printf("%d %s\n", i, &str[i % 26]);
		i++;
	}
    i = -2950;
	while (i > -3000)
	{
		//printf("%d %s\n", i, &str[i % 26]);
		//printf("%d %s\n", i, &str[i % 26]);
		//b_printf("%d %s\n", i, &str[i % 26]);
		printf("%d\n", i);
		i--;
	}*/

    printf("m: %d %d %o %x %u %u\n", max, min, 2147483647, 2147483647, UINT_MAX, 2147483647);
	printf("%d %d %o %x %u\n\n", max, min, 2000, 2000, UINT_MAX);
	printf("Zeros: %d %i %o %x %u\n", zero, zero, zero, zero, zero);
	printf("%p %s %c %c\n", str, str, str[2], str[25]);
	printf("%d %d %o %x %u\n", max, min, -42, -42, UINT_MAX);
	printf("%o\n", UINT_MAX);
	return (0);
}