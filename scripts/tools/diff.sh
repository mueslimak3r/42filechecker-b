#!/bin/bash

cd $1
diff "logs/yourLog" "refLog" | less -R