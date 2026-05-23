#!/bin/bash

# Github directory

export WORK_USER=kbalu
export HOME_USER=balukarthik

export WORK_GIT=$HOME/work-git
export GITHUB=$HOME/github

export HOME_GIT_HOME=$GITHUB/$HOME_USER
export WORK_GIT_HOME=$WORK_GIT/$WORK_USER

export WORK_GIT_URL=https://github.qualcomm.com/
export HOME_GIT_URL=https://github.com/

export GITHUB_HOME=$HOME_GIT_HOME
export GITHUB_URL=$HOME_GIT_URL

# Notes directory
export NOTES=$GITHUB_HOME/Notes

# Notes directory
export SETUP=$GITHUB_HOME/Setup

# Lists directory
export LISTS=$GITHUB_HOME/Lists

# Vim is my editor
export VISUAL=emacs
export EDITOR="$VISUAL"

# Environment specific updates
if [[ "$OSTYPE" == "linux-gnu"* ]];
then
    # ...
    :
elif [[ "$OSTYPE" == "darwin"* ]];
then
    # Mac OSX
    :
elif [[ "$OSTYPE" == "cygwin" ]];
then
    # POSIX compatibility layer and Linux environment emulation for Windows
    :
elif [[ "$OSTYPE" == "msys" ]];
then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    :
elif [[ "$OSTYPE" == "win32" ]];
then
    # I'm not sure this can happen.
    :
elif [[ "$OSTYPE" == "freebsd"* ]];
then
    # ...
    :
else
    # Unknown.
    :
fi
