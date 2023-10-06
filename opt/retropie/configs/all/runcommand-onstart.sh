#!/bin/sh
## Uncomment one or all of the following if you need to find some information about the emulator or roms
## Name of the emulator
#echo $1 >> /dev/shm/runcommand.log

## Name of the software used for running the emulation
#echo $2 >> /dev/shm/runcommand.log

## Name of the rom
#echo $3 >> /dev/shm/runcommand.log

##Executed command line
#echo $4 >> /dev/shm/runcommand.log

### The FUN begins
#Get ROM name striping full path
rom="${3##*/}"

### Try to automatically find the correct event[•] of the connected controllers
controller1=`cat /proc/bus/input/devices | egrep -i "js*" | sort | grep -o 'event[0-9]' | sed -n -e '1{p;q}'`
controller2=`cat /proc/bus/input/devices | egrep -i "js*" | sort | grep -o 'event[0-9]' | sed -n -e '2{p;q}'`


### Set variables for your joypad and emulator
### Basic Configurations - Standard controller mappings
drvHead="sudo /opt/retropie/supplementary/xboxdrv/bin/xboxdrv >> /dev/shm/runcommand.log 2>&1 \
	--daemon \
	--detach \
	--dbus disabled \
	--detach-kernel-driver"
basicSN30="--evdev /dev/input/$controller1 \
	--id 0 \
	--device-name 'Player One' \
	--led 2 \
	--deadzone 4000 \
	--silent \
	--trigger-as-button"
basicXbox="--next-controller \
	--evdev /dev/input/$controller2 \
	--id 1 \
	--device-name 'Player Two'\
	--led 3 \
	--deadzone 4000 \
	--silent \
	--trigger-as-button"

### Extended Configurations
### Specific emulator configuration or any other parameters you will need only for some emulators
scummVM="--ui-axismap x1=REL_X:10,y1=REL_Y:10 \
    --ui-axismap x2=REL_X:10,y2=REL_Y:10 \
    --ui-buttonmap b=BTN_LEFT,a=BTN_RIGHT,x=KEY_Y,y=KEY_X,back=KEY_ESC \
    --ui-buttonmap start=KEY_LEFTCTRL+KEY_F5 \
    --ui-buttonmap du=KEY_UP,dd=KEY_DOWN,dl=KEY_LEFT,dr=KEY_RIGHT \
    --ui-buttonmap lb=KEY_S,rb=KEY_F,lt=KEY_W,rt=KEY_R \
    --ui-buttonmap back+start=KEY_LEFTALT+KEY_F4"

atari="--axismap X1=DPAD_X,Y1=DPAD_Y \
	--buttonmap B=A"

fourway="--four-way-restrictor"

invert="--ui-buttonmap du=KEY_DOWN,dd=KEY_UP"

### Kill Command
xboxkill="sudo killall >>/dev/shm/runcommand.log xboxdrv"

### Execute the driver with the configuration you need
# $1 is the name of the emulation, not the name of the software used
# it is intellivision not jzintv
case $1 in
    atari2600)
        eval $xboxkill
        joycommand="$drvHead $basicSN30 $atari $basicXbox $atari &"
        eval $joycommand
    ;;
    scummvm)
        eval $xboxkill
        joycommand="$drvHead $basicSN30 $scummVM $basicXbox $scummVM &"
        eval $joycommand
    ;;
esac