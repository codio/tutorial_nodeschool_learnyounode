#!/bin/bash

# Check parameters
if [[ "$#" -ne 3 ]]; then
    echo "3 parameters required"
    exit 0
fi

# Translate lesson name into correct name for Workshopper projects
if [ $2 == "hello_world" ]; then
    STR="HELLO WORLD"
elif [ $2 == "baby_steps" ]; then
    STR="BABY STEPS"
elif [ $2 == "my_first_io" ]; then
    STR="MY FIRST I/O!"
elif [ $2 == "my_first_async_io" ]; then
    STR="MY FIRST ASYNC I/O!"
elif [ $2 == "filtered_ls" ]; then
    STR="FILTERED LS"
elif [ $2 == "make_it_modular" ]; then
    STR="MAKE IT MODULAR"
elif [ $2 == "http_client" ]; then
    STR="HTTP CLIENT"
elif [ $2 == "http_collect" ]; then
    STR="HTTP COLLECT"
elif [ $2 == "juggling_async" ]; then
    STR="JUGGLING ASYNC"
elif [ $2 == "time_server" ]; then
    STR="TIME SERVER"
elif [ $2 == "http_file_server" ]; then
    STR="HTTP FILE SERVER"
elif [ $2 == "http_uppercaserer" ]; then
    STR="HTTP UPPERCASERER"
elif [ $2 == "http_json_api_server" ]; then
    STR="HTTP JSON API SERVER"
else
    echo UNKNOWN: Make sure you have your code file selected before running/verifying
    exit 0
fi
echo SELECTED FILE IS : $STR

#Select the workshopper lesson
learnyounode select $STR > /dev/null

# Run or Verify?
if [ $1 == "run" ]; then
    learnyounode run $3/$2.js
elif [ $1 == "verify" ]; then
    learnyounode verify $3/$2.js
else 
    echo "BAD COMMAND"
fi

