#!/bin/bash

argument=$1

if [[ $argument == *.sh ]]
then
    #Is a script file, execute script
    cmd=$argument
elif [[ $argument == *.p8 || $argument == *.png ]]
then
    #Is a game image, start the game. But need to escape string first
    #List of charaters to be escaped
    characters=("\'" "\ " "\(" "\)")

    #Start escaping string
    for item in "${characters[@]}"
    do
        argument=${argument//$item/"$item"}
    done

    cmd="/home/pi/pico-8/pico8_dyn -run $argument"
else
    #unsupported file format
    exit
fi

/opt/retropie/supplementary/runcommand/runcommand.sh 0 "$cmd"
