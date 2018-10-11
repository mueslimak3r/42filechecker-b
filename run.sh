#!/bin/bash

git clean -f -d
git pull
case $1 in
    "b_libft" ) sh scripts/b_libft/b_libft.sh "$2";;
    "b_printf" ) sh scripts/b_printf/b_printf.sh "$2";;
    "b_ls" ) sh scripts/b_ls/b_ls.sh "$2";;
    "update" ) git reset --hard origin/master
    *) echo "Invalid. Use ./run [projName] [projPath]";;
esac
