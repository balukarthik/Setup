#!/bin/bash
get_script_dir()
{
    local SOURCE_PATH="${BASH_SOURCE[0]}"
    local SYMLINK_DIR
    local SCRIPT_DIR
    # Resolve symlinks recursively
    while [ -L "$SOURCE_PATH" ]; do
        # Get symlink directory
        SYMLINK_DIR="$( cd -P "$( dirname "$SOURCE_PATH" )" >/dev/null 2>&1 && pwd )"
        # Resolve symlink target (relative or absolute)
        SOURCE_PATH="$(readlink "$SOURCE_PATH")"
        # Check if candidate path is relative or absolute
        if [[ $SOURCE_PATH != /* ]]; then
            # Candidate path is relative, resolve to full path
            SOURCE_PATH=$SYMLINK_DIR/$SOURCE_PATH
        fi
    done
    # Get final script directory path from fully resolved source path
    SCRIPT_DIR="$(cd -P "$( dirname "$SOURCE_PATH" )" >/dev/null 2>&1 && pwd)"
    echo "$SCRIPT_DIR"
}

echo "get_script_dir: $(get_script_dir)"

chmod u+x $(get_script_dir)/*.sh

source $(get_script_dir)/env.sh
source $(get_script_dir)/alias.sh

# Make some directories if they don't exist yet...
mkdir -p $HOME/bin
chmod u+x $HOME/bin

# Copy setup.sh to home directory and change
cp $SETUP/setup.sh $HOME/bin
chmod u+x $HOME/bin/setup.sh

# Copy environment setting file to home directory and run it
cp $SETUP/env.sh $HOME/bin
chmod u+x $HOME/bin/env.sh
source $HOME/bin/env.sh

# Copy alias setting file to home directory and run it
cp $SETUP/alias.sh $HOME/bin
chmod u+x $HOME/bin/alias.sh
source $HOME/bin/alias.sh

# Copy binary files from Setup directory to $HOME
cp -r $GITHUB_HOME/Setup/bin/*   $HOME/bin

# vim stuff
cp    $GITHUB_HOME/Setup/.vimrc $HOME/
cp -r $GITHUB_HOME/Setup/.vim   $HOME/

# Set environment variables upon startup
if grep -Fxq "source \$HOME/bin/env.sh" $HOME/.bashrc
then
   # Nothing to be done here
   :
else
   echo 'source $HOME/bin/env.sh' >> $HOME/.bashrc
fi

if grep -Fxq "source \$HOME/bin/alias.sh" $HOME/.bashrc
then
   # Nothing to be done here
   :
else
   echo 'source $HOME/bin/alias.sh' >> $HOME/.bashrc
fi

# Remember git credentials
git config --global credential.helper store

# Clone all repos
git clone $GITHUB_URL/$WORK_USER/Scripts $GITHUB_HOME/Scripts
git clone $GITHUB_URL/$WORK_USER/Notes   $GITHUB_HOME/Notes
git clone $GITHUB_URL/$WORK_USER/Lists   $GITHUB_HOME/Lists

# Copy scripts to $HOME/bin directory and run it
mkdir -p $HOME/bin
cp $GITHUB_HOME/Scripts/*.sh $HOME/bin
chmod u+x $HOME/bin/*.sh

# Update $PATH to include $HOME/bin
if grep -Fxq "PATH=\$PATH:\$HOME/bin/" $HOME/.bashrc
then
   # Nothing to be done here
   :
else
   echo 'PATH=$PATH:$HOME/bin/' >> $HOME/.bashrc
   PATH=$PATH:$HOME/bin
fi

# Environment specific updates
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
    ln -s $HOMEPATH/Dropbox/Documents/Notes $HOME/symlinks/Notes
    # Update $PATH to include $HOME/bin
    if grep -Fxq "PATH=\$PATH:/mingw64/bin/" $HOME/.bashrc
    then
        # Nothing to be done here
        :
    else
        echo 'PATH=$PATH:/mingw64/bin/' >> $HOME/.bashrc
        PATH=$PATH:/mingw64/bin
    fi
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

$HOME/bin/cron.sh $HOME/bin/sync-all.sh

echo "Setup Complete"


