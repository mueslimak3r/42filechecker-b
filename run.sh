#!/bin/bash

red='\033[1;31m' 
NC='\033[0m'
green='\033[01;32m'

if [ "$3" == "offline" ] ; then
    echo && echo -e "${green}offline mode${NC}" && echo
else
    echo && echo -e "${green}use${NC} \"./run.sh "$1" "$2" offline\"${green} to suppress updates${NC}"
    echo && echo -e "${green}checking for updates${NC}"

    filename="run.sh"
    if [[ $(uname -s) == Linux ]]
    then
        m1=$(md5sum "$filename")
    else
        m1=$(md5 "$filename")
    fi

    git fetch
    git clean -dfx
    git pull

    if [[ $(uname -s) == Linux ]] ; then
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
fi

case $1 in
    "b_libft" ) bash scripts/b_libft/b_libft.sh "$2";;
    "b_printf" ) bash scripts/b_printf/b_printf.sh "$2";;
    "b_ls" ) bash scripts/b_ls/b_ls.sh "$2";;
    "diff" )
            if [ -e "$2" ] ; then
                cd "$2"
                diff "logs/yourLog" "logs/refLog" > /dev/null 2>&1
                error=$?
                if [ $error -eq 0 ] ; then
                    echo -e "${green}your log:${NC}"
                    echo && cat logs/yourLog
                    echo && echo && echo -e "${green}ref log:${NC}"
                    echo && cat logs/refLog
                    echo && echo && echo -e "${green}passed!${NC}"
                    echo
                elif [ $error -eq 1 ] ; then
                    echo -e "${red}your log:${NC}"
                    echo && cat logs/yourLog
                    echo && echo && echo -e "${green}ref log:${NC}"
                    echo && cat logs/refLog
                    echo && echo && echo -e "${red}diff:${NC}"
                    echo && diff "logs/yourLog" "logs/refLog" | cat
                    echo && echo -e "${red}outputs dont match!${NC}" && echo
                else
                    echo -e "${red}something went wrong!${NC}"
                    exit 1
                fi
            else
                echo -e "${red}project not found!${NC}"
                exit 1
            fi;;
    "cleanup" )
            if [ -e "$2" ] ; then
            cd "$2" && rm -rf logs
            make fclean
            fi;;
    * ) echo -e "${red}usage: ./run.sh [projName] [projPath]${NC}";;
esac
