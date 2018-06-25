#!/bin/bash
#pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY bash /home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh --desat_proxy
if [ "$1" = "true" ]
then
	exit 0
else 
	exit -1
fi