#!/bin/bash

INIT_FILE="~/.bashrc"
TO_ADD_FILE="hotgit.sh"
CURRENT_DIR=`pwd`

IMPORTED=`grep -q "$TO_ADD_FILE" ~/.bashrc && echo T || echo F`

if [ $IMPORTED == "F" ]; then
	echo "source $CURRENT_DIR/$TO_ADD_FILE" >> ~/.bashrc
	echo "hotgit.sh added to ~/.bashrc"
fi

source ~/.bashrc
