#!/bin/bash


# Github directory
export GITHUB=$HOME/github
export GITHUB_HOME=$GITHUB/balukarthik
export GITHUB_WORK=$GITHUB/kbalu

# Notes directory
export NOTES=$GITHUB_HOME/Notes

# Vim is my editor
export VISUAL=vim
export EDITOR="$VISUAL"

# CD Path
export CDPATH=$HOME/symlinks

# Environment specific updates
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # ...
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
        # Unknown.
fi

