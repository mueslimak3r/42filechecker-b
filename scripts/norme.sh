#!/bin/bash
cd $1
rm -rf refLog yourLog logs refProg.dSYM yourProg.dSYM
norminette -R CheckForbiddenSourceHeader