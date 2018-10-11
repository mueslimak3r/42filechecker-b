#!/bin/bash
cd $1
rm -rf refLog yourLog logs refProg.dSYM
norminette -R CheckForbiddenSourceHeader