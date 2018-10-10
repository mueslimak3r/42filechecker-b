#!/bin/bash

n="$1"
case $n in
    "b_libft" ) ./b_libft/b_libft.sh "$2";;
    "b_printf" ) ./b_printf/b_printf.sh "$2";;
    "b_ls" ) ./b_ls/b_ls.sh "$2";;
    *) echo "Invalid. Use ./run [projName] [projPath]";;
esac
