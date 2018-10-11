#!/bin/bash

# open directory and check makefile

red='\033[4;31m' 
nc='\033[0m'
green='\033[4;32m'
yourtest="scripts/b_libft/yourmain.c"
reftest="scripts/b_libft/refmain.c"
dirName="$1"
if [ -e "$dirName" ] ; then
    sh scripts/norme.sh "$1"
    cp -- "$yourtest" "$dirName"
    cp -- "$reftest" "$dirName"
    cd -- "$dirName"
    if [ -e "author" ] ; then
        echo -e "${green}found author file${NC}"
    else
        echo "${red}missing author file!${NC}"
    fi
    if make re >/dev/null ; then
        if make fclean >/dev/null ; then
            echo "${green}passed makefile test${nc}"
            make re >/dev/null && make clean >/dev/null
        else
            echo "${red}make fclean error!${nc}"
        fi
    else
        echo "${red}make re error!${nc}"
        rm -rf yourmain.c refmain.c
        exit 1
    fi
else
    echo "${red}Project not found! Use ./run [projName] [projPath]${nc}"
fi

# compile and eval main

if gcc -g -fsanitize=address -Wall -Wextra -Werror yourmain.c libft.a -o yourProg ; then
    if ./yourProg | cat -e > yourLog; then
        gcc -g -fsanitize=address -Wall -Wextra -Werror refmain.c -o refProg
        rm -rf yourmain.c refmain.c yourProg.dSYM
    else
        echo "${red}runtime error!${nc}"
        rm -rf yourmain.c refmain.c yourProg.dSYM
        exit 1
    fi
else
    echo "${red}compile error!${nc}"
    rm -rf yourmain.c refmain.c yourProg.dSYM
    exit 1
fi

# compare your output to the standard functions

./refProg | cat -e > refLog
DIFF=$(diff yourLog refLog)
if [ "$DIFF" == "" ] ; then
    echo "${green}pass!${nc}"
else
    echo "${red}Outputs don't match! Check log files in project directory${nc}"
fi
rm -rf refProg yourProg yourProg.dSYM