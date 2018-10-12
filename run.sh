#!/bin/bash
red='\033[1;31m' 
NC='\033[0m'
green='\033[01;32m'
echo && echo -e "${green}checking for updates${NC}"

filename="run.sh"

if [[ $(uname -s) == Linux ]]
then
    m1=$(md5sum "$filename")
else
    m1=$(md5 "$filename")
fi

git clean -f
git reset --hard origin/master

if [[ $(uname -s) == Linux ]]
then
    m2=$(md5sum "$filename")
else
    m2=$(md5 "$filename")
fi
if [ "$m1" != "$m2" ] ; then
    echo -e "${red}updated. relaunching${NC}"
    ./run.sh "$1" "$2"
    exit 0
fi

echo -e "${green}finished update check${NC}" && echo

case $1 in
    "b_libft" ) sh scripts/b_libft/b_libft.sh "$2";;
    "b_printf" ) sh scripts/b_printf/b_printf.sh "$2";;
    "b_ls" ) sh scripts/b_ls/b_ls.sh "$2";;
    "getnew" ) git -f clean && git reset --hard origin/master;;
    "cleanup" )
        if [ -e "$2" ] ; then
            cd "$2" && rm -rf logs
            make fclean
        fi;;
    * ) echo -e "${red}Invalid. Use ./run [projName] [projPath]${NC}";;
esac