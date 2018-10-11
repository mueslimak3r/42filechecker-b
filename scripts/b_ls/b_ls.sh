#!/bin/bash

# open directory and check makefile

red='\033[4;31m' 
nc='\033[0m'
green='\033[4;32m'
dirName="$1"
if [ -e "$dirName" ] ; then
    sh scripts/norme.sh "$1" && echo
    cd "$dirName"
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
        echo "${red}make re error!${nc}"
        exit 1
    fi
else
    echo "${red}Project not found! Use ${nc}./run [projName] [projPath]"
    exit 1
fi


mkdir logs
touch logs/yourLog
touch logs/refLog

# tests

if ./b_ls | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls | tr '\r\n' ' ' | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atl | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls -atl -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atlr -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls -atlr -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

echo "next tests" >> logs/yourLog
echo "next tests" >> logs/refLog

mkdir ab
touch ab/afile ab/cfile
mkdir ac
mkdir za
touch ac/afile ac/cfile

if ./b_ls -tlr -- ac za ab | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls -tlr -- ac za ab | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    rm -rf ab ac
    exit 1
fi

rm -rf ab ac za

# compare your output to the standard functions

DIFF=$(diff logs/yourLog logs/refLog)
if [ "$DIFF" == "" ] ; then
    echo "${green}Passed!${nc}" && echo
else
    echo "${red}Outputs don't match! Check log files in project directory${nc}"
fi
rm -rf b_ls.dSYM