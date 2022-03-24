#!/bin/bash

export USER=vncuser

set -exu
vncserver
DISPLAY=:1 dwm &
exec websockify --web=/usr/share/novnc/ 6080 localhost:5901
