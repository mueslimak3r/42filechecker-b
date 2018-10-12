#!/bin/bash

# open directory and check makefile

red='\033[1;31m' 
nc='\033[0m'
green='\033[01;32m'
yourtest="scripts/b_libft/yourmain.c"
reftest="scripts/b_libft/refmain.c"
dirName="$1"
if [ -e "$dirName" ] ; then
    sh scripts/norme.sh "$1"
    echo
    cp -- "$yourtest" "$dirName"
    cp -- "$reftest" "$dirName"
    cd -- "$dirName"
    if [ -e "author" ] ; then
        if [ $(cat -e author | sed -n '$s/.*\(.\)$/\1/p') ==  "$" ] ; then
            echo "${green}Author file passes!${nc}"
        else
            echo "${red}Author file found but is invalid!${nc}"
        fi
    else
        echo "${red}Author file is missing!${nc}"
    fi
    if make re >/dev/null ; then
        if make fclean >/dev/null ; then
            echo "${green}Passed makefile test${nc}"
            make re >/dev/null && make clean >/dev/null
        else
            echo "${red}Make fclean error!${nc}"
        fi
    else
        echo "${red}Make re error!${nc}"
        rm -rf yourmain.c refmain.c
        exit 1
    fi
else
    echo "${red}Project not found! Use ${nc}./run [projName] [projPath]"
    exit 1
fi

# compile and eval main

mkdir logs

if gcc -g -fsanitize=address -Wall -Wextra -Werror yourmain.c libft.a -o yourProg ; then
    if ./yourProg | cat -e > logs/yourLog; then
        gcc -g -fsanitize=address -Wall -Wextra -Werror refmain.c -o refProg
        rm -rf yourmain.c refmain.c yourProg.dSYM
    else
        echo "${red}Runtime error!${nc}"
        rm -rf yourmain.c refmain.c yourProg.dSYM
        exit 1
    fi
else
    echo "${red}Compile error!${nc}"
    rm -rf yourmain.c refmain.c yourProg.dSYM
    exit 1
fi

# compare your output to the standard functions

./refProg | cat -e > logs/refLog
DIFF=$(diff logs/yourLog logs/refLog)

if [ "$DIFF" = "" ] ; then
    echo "${green}Passed!${nc}" && echo
else
    echo "${red}Outputs don't match! Check log files in project directory${nc}"
fi
rm -rf refProg yourProg yourProg.dSYM refProg.dSYM