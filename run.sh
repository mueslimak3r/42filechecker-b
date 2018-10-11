#!/bin/bash
filename="run.sh"
m1=$(md5sum "$filename")
git fetch origin master
git reset --hard origin/master
m2=$(md5sum "$filename")
if [ "$m1" != "$m2" ] ; then
    ./run.sh "$1" "$2"
    exit 0
fi
case $1 in
    "b_libft" ) sh scripts/b_libft/b_libft.sh "$2";;
    "b_printf" ) sh scripts/b_printf/b_printf.sh "$2";;
    "b_ls" ) sh scripts/b_ls/b_ls.sh "$2";;
    "getnew" ) git reset --hard origin/master;;
    "cleanup" )
        if [ -e "$2" ] ; then
            cd "$2" && rm -rf logs
            make fclean
        fi;;
    * ) echo "Invalid. Use ./run [projName] [projPath]";;
esac