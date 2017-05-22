#!/bin/bash

INIT_FILE="~/.bashrc"
TO_ADD_FILE="hotgit.sh"
DIR_OF_THIS_SCRIPT="$(cd "$(dirname -- "${BASH_SOURCE}")"; echo "$(pwd)")"

IMPORTED=`grep -q "$TO_ADD_FILE" ~/.bashrc && echo T || echo F`

if [ $IMPORTED == "F" ]; then
	echo "source $DIR_OF_THIS_SCRIPT/$TO_ADD_FILE" >> ~/.bashrc
	echo "hotgit.sh added to ~/.bashrc"
fi
