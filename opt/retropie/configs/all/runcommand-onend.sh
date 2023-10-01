#!/bin/sh
sudo killall >> /dev/shm/runcommand.log 2>&1 xboxdrv
sudo /opt/retropie/supplementary/xboxdrv/bin/xboxdrv >> /dev/shm/runcommand.log 2>&1 \
	--daemon \
	--detach \
	--dbus disabled \
	--detach-kernel-driver \
	--id 0 \
	--device-name 'Player One' \
	--led 2 \
	--deadzone 4000 \
	--silent \
	--trigger-as-button \
	--next-controller \
	--id 1 \
	--device-name 'Player Two'\
	--led 3 \
	--deadzone 4000 \
	--silent \
	--trigger-as-button \