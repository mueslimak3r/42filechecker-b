#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int         main(void)
{
    char    *str;
    char    *top;
    int     i;

    // the basics
    puts("\n\nbasic functions\n");

    putchar('c');
    putchar(0);
    if (isdigit('9') != 0)
        printf("isdigit: 1\n");
    else
        printf("isdigit: 1\n");
    printf("toupper: %c, tolower: %c\n", toupper(113), tolower(81));

    // strcmp section
    printf("\n\nstrcmp tests\n\n");

    i = strcmp("", "abc");
    printf("strcmp: %d\n", ((i < 0) ? -1 : ((i > 0) ? 1 : 0)));
    i = strcmp("abc", "abc");
    printf("strcmp: %d\n", ((i < 0) ? -1 : ((i > 0) ? 1 : 0)));
    i = strcmp("abcdefzfd", "abcdefse");
    printf("strcmp: %d\n", ((i < 0) ? -1 : ((i > 0) ? 1 : 0)));

    //string stuff
    printf("\n\nstring stuff\n\n");

    str = strdup("Hello #World");
    printf("%s\n", str);
    top = str;
    str = strchr(str, '#');
    printf("strchr: %c%c\n", *str, *(str + 1));
    str = top;
    str = memset(str, 'Z', (int)strlen(str));
    printf("%s\n", str);
    str = strcpy(str, "Hello #World");
    printf("%s\n", str);
    str = memset(str, 'Z', (int)strlen(str));
    str = strncpy(str, "Hello #World", (int)strlen(str));
    printf("%s\n", str); 
    free (str);
    return (0);
}