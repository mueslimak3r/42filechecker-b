#!/bin/bash
red='\033[1;31m'
nc='\033[0m'
green='\033[01;32m'
cd $1
rm -rf refLog yourLog logs refProg.dSYM yourProg.dSYM
if [[ $(command -v norminette | grep -e) == "0" ]]
then
    echo "${red}No norminette :'(${nc}"
else
    norminette -R CheckForbiddenSourceHeader
fi