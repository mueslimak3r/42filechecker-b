#!/bin/bash

# open directory and check makefile

yourtest="scripts/b_printf/yourmain.c"
reftest="scripts/b_printf/refmain.c"
dirName="$1"
if [ -e "$dirName" ] ; then
    sh scripts/norme.sh "$1"
    echo && echo && echo "Make sure your header file is includes/b_printf.h!!!"
    echo
    cp -- "$yourtest" "$dirName"
    cp -- "$reftest" "$dirName"
    cd -- "$dirName"
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
        echo "if header not found change include statement in scripts/project/yourmain.c"
        rm -f yourmain.c refmain.c
        exit 1
    fi
else
    echo "Project not found! Use ./run [projName] [projPath]"
fi

# compile and eval main

mkdir logs

if gcc -g -fsanitize=address -Wall -Wextra -Werror yourmain.c libftprintf.a -o yourProg ; then
    if ./yourProg | cat -e > logs/yourLog; then
        gcc -g -fsanitize=address -Wall -Wextra -Werror refmain.c -o refProg
        rm -f yourmain.c refmain.c
    else
        echo "runtime error!"
        rm -f yourmain.c refmain.c
        exit 1
    fi
else
    echo "compile error!"
    echo "if header not found change include statement in scripts/project/yourmain.c"
    rm -f yourmain.c refmain.c
    exit 1
fi

# compare your output to the standard functions

./refProg | cat -e >> logs/refLog

DIFF=$(diff logs/yourLog logs/refLog)

if [ "$DIFF" = "" ] ; then
    echo "pass!"
else
    echo "Outputs don't match! Check log files in project directory"
fi
rm -f refProg yourProg