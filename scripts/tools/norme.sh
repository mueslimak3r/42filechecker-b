#!/bin/bash
red='\033[1;31m'
nc='\033[0m'
green='\033[01;32m'
yellow='\033[0;33m'
cd $1
rm -rf refLog yourLog logs refProg.dSYM yourProg.dSYM
if [ $(command -v norminette | grep -e "") == "0" ]
then
    echo "${red}No norminette :'(${nc}"
else
    norminette > norm_save
    warnings=$(grep -c "^Warning" norm_save)
    errs=$(grep -c "^Error" norm_save)
    cat norm_save
    echo && echo "You have $warnings ${yellow}warning(s)${nc}"
    echo "You have $errs ${red}error(s)${nc}"
    rm -f norm_save
fi