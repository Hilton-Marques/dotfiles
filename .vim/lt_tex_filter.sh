#!/bin/bash

#
#   interface between vim-grammarous or vim-LanguageTool and yalafi.shell
#   - collect all options passed by editor, except --api
#   - languagetool-commandline.jar is a bit picky with repeated options
#

#   LT's base directory
#
ltdir=/home/hiltonms/Documents/Programas/languagetool

#   comment out to use languagetool-commandline
#
#use_server="--server my"

#   vim-grammarous needs byte offsets in XML report
#   --> set to xml-b
#
output=xml-b
output=xml

opts=x
lang=en-GB
while [ $# -gt 1 ]
do
    if [ X$1 == X-l ]
    then
        # languagetool-commandline does not like multiple language specs
        shift
        lang=$1
    elif [ X$1 == X-c ]
    then
        # languagetool-commandline does not like multiple encoding specs
        # (yalafi.shell already includes --encoding utf-8)
        shift
    elif [ X$1 != X--api ]
    then
        opts+="$1 "
    fi
    shift
done

python3 -m yalafi.shell $use_server --output $output --language $lang \
            --lt-directory $ltdir --lt-options "$opts" $1 2>/dev/null


