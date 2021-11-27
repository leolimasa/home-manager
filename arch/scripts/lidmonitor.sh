#!/bin/bash

if [ ! -z "$INSTALL" ]; then
	echo "Installing service"
	exit
fi

started_suspension=false
while true
do
	is_lid_open=$(cat /proc/acpi/button/lid/LID0/state | grep open)
	if [ -z "$is_lid_open" ] && [ "$started_suspension" = false ]; then
		started_suspension=true
		date
		echo "suspending system"
		sleep 5
		systemctl suspend-then-hibernate
	fi
	if [ ! -z "$is_lid_open" ] && [ "$started_suspension" = true ]; then
		started_suspension=false
		date
		echo "resuming from suspend"
	fi
	sleep 1
done

