#!/bin/bash

# open directory and check makefile

yourtest="scripts/b_libft/yourmain.c"
reftest="scripts/b_libft/refmain.c"
dirName="$1"
if [ -e "$dirName" ] ; then
    sh scripts/norme.sh "$1"
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
        rm -rf yourmain.c refmain.c
        exit 1
    fi
else
    echo "Project not found! Use ./run [projName] [projPath]"
fi

# compile and eval main

if gcc -g -fsanitize=address -Wall -Wextra -Werror yourmain.c libft.a -o yourProg ; then
    if ./yourProg | cat -e > yourLog; then
        gcc -g -fsanitize=address -Wall -Wextra -Werror refmain.c -o refProg
        rm -rf yourmain.c refmain.c yourProg.dSYM
    else
        echo "runtime error!"
        rm -rf yourmain.c refmain.c yourProg.dSYM
        exit 1
    fi
else
    echo "compile error!"
    rm -rf yourmain.c refmain.c yourProg.dSYM
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
rm -rf refProg yourProg yourProg.dSYM