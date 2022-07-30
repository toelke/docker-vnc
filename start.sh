#!/bin/bash

export USER=vncuser
export VNCSERVER_ARGS="${VNCSERVER_ARGS:=}"

set -exu
vncserver $VNCSERVER_ARGS
DISPLAY=:1 dwm &
exec websockify --web=/usr/share/novnc/ 6080 localhost:5901
