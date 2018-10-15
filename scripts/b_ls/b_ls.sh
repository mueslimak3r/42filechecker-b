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

mkdir /tmp/testdir_a
touch /tmp/testdir_a/file1
touch /tmp/testdir_a/file2
mkdir /tmp/testdir_b
touch /tmp/testdir_b/file2
touch /tmp/testdir_b/file1
mkdir /tmp/testdir_c
touch /tmp/testdir_c/file3
touch /tmp/testdir_c/file1
touch /tmp/testdir_c/file2
ln -s /tmp/testdir_a/file2 /tmp/testdir_c/link1

if ./b_ls | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/yourLog; then
    ls | tr '\r\n' ' ' | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/refLog
else
    echo -e "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atl --  /tmp/testdir_c | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/yourLog; then
    ls -atl -- /tmp/testdir_c | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/refLog
else
    echo -e "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atlr -- . | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/yourLog; then
    ls -atlr -- . | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/refLog
else
    echo -e "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -tlr -- /tmp/testdir_b /tmp/testdir_a /tmp/testdir_c . | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/yourLog; then
    ls -tlr -- /tmp/testdir_b /tmp/testdir_a /tmp/testdir_c . | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11'} >> logs/refLog
else
    echo -e "${red}runtime error!${nc}"
    rm -rf b_ls.dSYM
    rm -rf /tmp/testdir_a /tmp/testdir_b /tmp/testdir_c
    exit 1
fi

rm -rf /tmp/testdir_a /tmp/testdir_b /tmp/testdir_c

# compare your output to the standard functions

DIFF=$(diff logs/yourLog logs/refLog)
if [ "$DIFF" == "" ] ; then
    echo -e "${green}passed!${nc}" && echo
else
    echo -e "${red}outputs dont match! Run ${nc}\"./run.sh diff "$1"\"${red} to view output${nc}"
fi
rm -rf b_ls.dSYM
