#!/bin/bash

# open directory and check makefile

red='\033[4;31m' 
nc='\033[0m'
green='\033[4;32m'
yourtest="scripts/b_printf/yourmain.c"
reftest="scripts/b_printf/refmain.c"
dirName="$1"
if [ -e "$dirName" ] ; then
    sh scripts/norme.sh "$1"
    echo && echo && echo "${red}Make sure your header file is includes/b_printf.h!!${nc}"
    echo
    cp -- "$yourtest" "$dirName"
    cp -- "$reftest" "$dirName"
    cd -- "$dirName"
    if [ -e "author" ] ; then
        echo "${green}found author file${nc}"
    else
        echo "${red}missing author file!${nc}"
    fi
    if make re >/dev/null ; then
        if make fclean >/dev/null ; then
            echo "${green}passed makefile test${nc}"
            make re >/dev/null && make clean >/dev/null
        else
            echo "${red}make fclean error!${nc}"
        fi
    else
        echo "${red}make re error!"
        echo "if header not found change include statement in scripts/project/yourmain.c${nc}"
        rm -f yourmain.c refmain.c
        exit 1
    fi
else
    echo "${red}Project not found! Use ./run [projName] [projPath]${nc}"
fi

# compile and eval main

mkdir logs

if gcc -g -fsanitize=address -Wall -Wextra -Werror yourmain.c libftprintf.a -o yourProg ; then
    if ./yourProg | cat -e > logs/yourLog; then
        gcc -g -fsanitize=address -Wall -Wextra -Werror refmain.c -o refProg
        rm -f yourmain.c refmain.c
    else
        echo "${red}runtime error!${nc}"
        rm -f yourmain.c refmain.c
        exit 1
    fi
else
    echo "${red}compile error!"
    echo "if header not found change include statement in scripts/project/yourmain.c${nc}"
    rm -f yourmain.c refmain.c
    exit 1
fi

# compare your output to the standard functions

./refProg | cat -e >> logs/refLog

DIFF=$(diff logs/yourLog logs/refLog)

if [ "$DIFF" = "" ] ; then
    echo "${green}pass!${nc} && echo"
else
    echo "${red}Outputs don't match! Check log files in project directory${nc} && echo"
fi
rm -f refProg yourProg