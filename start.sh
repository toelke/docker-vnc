#!/bin/bash

export VNCSERVER_ARGS="${VNCSERVER_ARGS:=}"

set -exu
/expectfile
vncserver $VNCSERVER_ARGS -listen tcp
sleep infinity
