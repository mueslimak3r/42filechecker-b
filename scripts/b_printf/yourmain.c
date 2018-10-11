#include "includes/b_printf.h"
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
		//b_printf("%d %s\n", i, &str[i % 26]);
		//b_printf("%d %s\n", i, &str[i % 26]);
		//b_b_printf("%d %s\n", i, &str[i % 26]);
        b_printf("%d %s\n", i, &str[i % 26]);
		i++;
	}
    i = -2950;
	while (i > -3000)
	{
		//b_printf("%d %s\n", i, &str[i % 26]);
		//b_printf("%d %s\n", i, &str[i % 26]);
		//b_b_printf("%d %s\n", i, &str[i % 26]);
		b_printf("%d\n", i);
		i--;
	}*/

    b_printf("%d %d %o %x %u %u\n", max, min, 2147483647, 2147483647, UINT_MAX, 2147483647);
	b_printf("%d %d %o %x %u\n\n", max, min, 2000, 2000, UINT_MAX);
	b_printf("Zeros: %d %i %o %x %u\n", zero, zero, zero, zero, zero);
	b_printf("%s %c %c\n", str, str[2], str[25]);
	b_printf("%d %d %o %x %u\n", max, min, -42, -42, UINT_MAX);
	b_printf("%o\n", UINT_MAX);
	return (0);
}