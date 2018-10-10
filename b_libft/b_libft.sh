#!/bin/bash

# open directory and check makefile

yourtest="b_libft/main.c"
reftest="b_libft/refmain.c"
dirName="$1"
if [ -e "$dirName" ] ; then
    cp -- "$yourtest" "$dirName"
    cp -- "$reftest" "$dirName"
    cd -- "$dirName"
    rm -f refLog yourLog
    norminette -R CheckForbiddenSourceHeader
    if [ -e "author" ] ; then
        echo "found author file"
    else
        echo "missing author file!"
    fi
    if make re >/dev/null ; then
        if make fclean >/dev/null ; then
            echo "passed makefile test"
            make re >/dev/null && make clean >/dev/null
        else
            echo "make fclean error!"
        fi
    else
        echo "make re error!"
        exit 1
    fi
else
    echo "Project not found! Use ./run [projName] [projPath]"
fi

# compile and eval main

if gcc -g -fsanitize=address -Wall -Wextra -Werror main.c libft.a -o yourProg ; then
    if ./yourProg | cat -e > yourLog; then
        gcc -g -fsanitize=address -Wall -Wextra -Werror refmain.c -o refProg
        rm -f main.c refmain.c
    else
        echo "runtime error!"
        exit 1
    fi
else
    echo "compile error!"
    exit 1
fi

# compare your output to the standard functions

./refProg | cat -e > refLog
DIFF=$(diff yourLog refLog)
if [ "$DIFF" == "" ] ; then
    echo "pass!"
else
    echo "Outputs don't match! Check log files in project directory"
fi
rm -f refProg yourProg