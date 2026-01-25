#!/bin/bash

read -p "Which packages do you want to install: " PACKAGE

echo $PACKAGE

sudo pacman -Sy $PACKAGE
