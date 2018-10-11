#!/bin/bash

# open directory and check makefile

dirName="$1"
if [ -e "$dirName" ] ; then
    sh scripts/norme.sh "$1"
    cd "$dirName"
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


mkdir logs
touch logs/yourLog
touch logs/refLog

# tests

if ./b_ls | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls | tr '\r\n' ' ' | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo "runtime error!"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atl | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls -atl -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo "runtime error!"
    rm -rf b_ls.dSYM
    exit 1
fi

if ./b_ls -atlr -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/yourLog; then
    ls -atlr -- | cat -e | awk {'print $1,$2,$3,$4,$5,$6,$7,$8,$9'} >> logs/refLog
else
    echo "runtime error!"
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
    echo "runtime error!"
    rm -rf b_ls.dSYM
    rm -rf ab ac
    exit 1
fi

rm -rf ab ac za

# compare your output to the standard functions

DIFF=$(diff logs/yourLog logs/refLog)
if [ "$DIFF" == "" ] ; then
    echo "pass!"
else
    echo "Outputs don't match! Check log files in project directory"
fi
rm -rf b_ls.dSYM