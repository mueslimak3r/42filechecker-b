#include <stdio.h>
#include <assert.h>
#include <limits.h>
#include <errno.h>

int			b_printf(const char *format, ...);

int			main(void)
{
	int  max = INT_MAX;
	int  min = INT_MIN;
	int  zero = 0;
	char str[] = "abcdefghijklmnopqrstuwxyz";
	/*
	int i;
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
	int		i = 0;
    i += b_printf("%d %d %o %x %u %u\n", max, min, 2147483647, 2147483647, UINT_MAX, 2147483647);
	i += b_printf("Zeros: %d %i %o %x %u\n", zero, zero, zero, zero, zero);
	i += b_printf("negative one: %d %i %o %x %u\n", -1, -1, -1, -1, -1);
	i += b_printf("%s %c %c\n", str, str[2], str[25]);
	i += b_printf("%o %o %x\n", UINT_MAX, UINT_MAX, UINT_MAX);
	b_printf("total: %d", i);
	return (0);
}
