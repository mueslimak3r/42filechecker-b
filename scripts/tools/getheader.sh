#!/bin/bash

red='\033[1;31m'
green='\033[01;32m'
nc='\033[0m'

cd "$1"
echo "${red}please enter the location/name of your .h file ${green}relative to root drectory of the project${nc}, then press enter."
echo "example: includes/b_printf.h"
read hlocation


echo "#include \""$hlocation"\"" > "yourmain.c"