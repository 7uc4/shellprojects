#!/bin/bash

#Demo of case statement.
#Case is a shell builtin command, for help type help case

case "${1}" in
    start)
        echo 'Starting.'
    ;;
    stop)
        echo 'Stopping.'
    ;;
    status | state)
        echo 'Status: '
    ;;
    *)
        echo 'Supply a valid option.' >&2
    exit 1
    ;;
esac