#!/usr/bin/env bash

if [ ! -z "$@" ]
then
    QUERY=$@
    if [[ "$@" == /* ]]
    then
        if [[ "$@" == *\?\? ]]
        then
            coproc ( exo-open "${QUERY%\/* \?\?}"  > /dev/null 2>&1 )
            exec 1>&-
            exit;
        else
            coproc ( exo-open "$@"  > /dev/null 2>&1 )
            exec 1>&-
            exit;
        fi
    elif [[ "$@" == \!\!* ]]
    then
        echo "!!-- Type your search query to find files"
        echo "!!-- To search again type !<search_query>"
        echo "!!-- To search parent directories type ?<search_query>"
        echo "!!-- You can print this help by typing !!"
    elif [[ "$@" == \?* ]]
    then
        echo "!!-- Type another search query"
        while read -r line; do
            echo "$line" \?\?
        done <<< $(find ~ -type d -path "*/\.*" -prune -o -not -name ".*" -type f -ipath "*${QUERY#\?}*" -print) | sort
    else
        echo "!!-- Type another search query"
        find ~ -type d -path "*/\.*" -prune -o -not -name ".*" -ipath "*${QUERY#!}*" -print | sort
    fi
else
    echo "!!-- Type your search query to find files"
    echo "!!-- To seach again type !<search_query>"
    echo "!!-- To seach parent directories type ?<search_query>"
    echo "!!-- You can print this help by typing !!"
fi
