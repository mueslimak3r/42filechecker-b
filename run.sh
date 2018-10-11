#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
Bgreen='\033[4;32m'
echo && echo -e "${Bgreen}checking for updates${NC}"

filename="run.sh"
m1=$(md5sum "$filename")
git fetch origin master
git reset --hard origin/master
m2=$(md5sum "$filename")
if [ "$m1" != "$m2" ] ; then
    echo -e "${RED}updated. relaunching${NC}"
    ./run.sh "$1" "$2"
    exit 0
fi

echo -e "${Bgreen}finished update check${NC}" && echo

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
    * ) echo -e "${RED}Invalid. Use ./run [projName] [projPath]${NC}";;
esac