#include "includes/b_printf.h"
#include <stdio.h>
#include <assert.h>
#include <limits.h>
#include <errno.h>

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
	FILE    *fp;
    fp = fopen ("logs/refLog","w");
    if (fp == NULL) {
        printf ("File not created okay, errno = %d\n", errno);
        return 1;
    }
	char paddr[15];
	if (!(snprintf(paddr, 15, "%p\n", &str)))
	{
		printf("error!\n");
		return (1);
	}
	fprintf(fp, ("p_flag: %s$\n"), paddr);
    fclose (fp);
	b_printf("p_flag: %p\n", &str);
    b_printf("%d %d %o %x %u %u\n", max, min, 2147483647, 2147483647, UINT_MAX, 2147483647);
	b_printf("%d %d %o %x %u\n\n", max, min, 2000, 2000, UINT_MAX);
	b_printf("Zeros: %d %i %o %x %u\n", zero, zero, zero, zero, zero);
	b_printf("negative one: %d %i %o %x %u\n", -1, -1, -1, -1, -1);
	b_printf("%s %c %c\n", str, str[2], str[25]);
	b_printf("%d %d %o %x %u\n", max, min, -42, -42, UINT_MAX);
	b_printf("%o\n", UINT_MAX);
	return (0);
}