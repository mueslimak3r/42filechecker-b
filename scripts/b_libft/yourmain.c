#include "libft.h"
#include <stdlib.h>
#include <stdio.h>

int     main(void)
{
    char    *str;
    char    *top;
    int     i;

    printf("isdigit: %d\n", ft_isdigit('9'));
    printf("toupper: %c, tolower: %c\n", ft_toupper(113), ft_tolower(81));

    // strcmp section
    printf("\n\nstrcmp tests\n\n");

    i = ft_strcmp("", "abc");
    printf("strcmp: %d\n", ((i < 0) ? -1 : ((i > 0) ? 1 : 0)));
    i = ft_strcmp("abc", "abc");
    printf("strcmp: %d\n", ((i < 0) ? -1 : ((i > 0) ? 1 : 0)));
    i = ft_strcmp("abcdefzfd", "abcdefse");
    printf("strcmp: %d\n", ((i < 0) ? -1 : ((i > 0) ? 1 : 0)));

    //string stuff
    printf("\n\nstring stuff\n\n");

    str = ft_strdup("Hello #World");
    printf("%s\n", str);
    top = str;
    str = ft_strchr(str, '#');
    printf("strchr: %c%c\n", *str, *(str + 1));
    str = top;
    str = ft_memset(str, 'Z', (int)ft_strlen(str));
    printf("%s\n", str);
    str = ft_strcpy(str, "Hello #World");
    printf("%s\n", str);
    str = ft_memset(str, 'Z', (int)ft_strlen(str));
    str = ft_strncpy(str, "Hello #World", (int)ft_strlen(str));
    printf("%s\n", str);
    free (str);
    return (0);
}