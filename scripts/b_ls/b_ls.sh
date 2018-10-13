#!/bin/bash

# open directory and check makefile

red='\033[1;31m'
nc='\033[0m'
green='\033[01;32m'
dirName="$1"
if [ -e "$dirName" ] ; then
    bash scripts/tools/norme.sh "$1"
    echo
    cd "$dirName"
    if [ -e "author" ] ; then
        if [ $(cat -e author | sed -n '$s/.*\(.\)$/\1/p') ==  "$" ] ; then
            echo -e "${green}author file passes!${nc}"
        else
            echo -e "${red}author file found but is invalid!${nc}"
        fi
    else
        echo -e "${red}author file is missing!${nc}"
    fi
    if make re >/dev/null ; then
        if make fclean >/dev/null ; then
            echo -e "${green}passed makefile test${nc}"
            make re >/dev/null && make clean >/dev/null
        else
            echo -e "${red}make fclean error!${nc}"
        fi
    else
        echo -e "${red}make re error!${nc}"
        exit 1
    fi
else
    echo -e "${red}project not found! Use ${nc}./run [projName] [projPath]"
    exit 1
fi


mkdir logs
touch logs/yourLog
touch logs/refLog

# tests

if ./b_ls | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls | tr '\r\n' ' ' | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo -e "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atl | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls -atl -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo -e "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atlr -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls -atlr -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo -e "${red}runtime error!${nc}"
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
    echo -e "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    rm -rf ab ac
    exit 1
fi

rm -rf ab ac za

# compare your output to the standard functions

DIFF=$(diff logs/yourLog logs/refLog)
if [ "$DIFF" == "" ] ; then
    echo -e "${green}passed!${nc}" && echo
else
    echo -e "${red}outputs dont match! Run ${nc}\"./run.sh diff "$1"\"${red} to view output${nc}"
fi
rm -rf b_ls.dSYM
