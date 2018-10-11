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

	int		i = 0;
    i += printf("%d %d %o %x %u %u\n", max, min, 2147483647, 2147483647, UINT_MAX, 2147483647);
	i += printf("Zeros: %d %i %o %x %u\n", zero, zero, zero, zero, zero);
	i += printf("negative one: %d %i %o %x %u\n", -1, -1, -1, -1, -1);
	i += printf("%s %c %c\n", str, str[2], str[25]);
	i += printf("%o %o %x\n", UINT_MAX, UINT_MAX, UINT_MAX);
	printf("total: %d", i);
	return (0);
}