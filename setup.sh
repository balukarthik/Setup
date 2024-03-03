#!/bin/bash

# If we see this script that means we this directory
SETUP_DIR="$HOME/github/balukarthik/Setup/"

# Make some directories if they don't exist yet...
mkdir -p $HOME/bin
mkdir -p $HOME/etc
mkdir -p $HOME/.todo
mkdir -p $HOME/share
mkdir -p $HOME/symlinks

chmod u+x $HOME/bin

# Copy setup.sh to home directory and change
cp $SETUP_DIR/setup.sh $HOME/bin
chmod u+x $HOME/bin/setup.sh

# Copy environment setting file to home directory and run it
cp $SETUP_DIR/env.sh $HOME/bin
chmod u+x $HOME/bin/env.sh
source $HOME/bin/env.sh

# Copy alias setting file to home directory and run it
cp $SETUP_DIR/alias.sh $HOME/bin
chmod u+x $HOME/bin/alias.sh
source $HOME/bin/alias.sh

# Install todo.sh
make -C $SETUP_DIR/todo.txt-cli
make -C $SETUP_DIR/todo.txt-cli install

cp -r $GITHUB_HOME/Setup/.todo.actions.d $HOME/
chmod -R u+x $HOME/.todo.actions.d


# Copy binary files from Setup directory to $HOME
cp -r $GITHUB_HOME/Setup/bin/*   $HOME/bin
cp -r $GITHUB_HOME/Setup/share/* $HOME/share                   
cp -r $GITHUB_HOME/Setup/etc/*   $HOME/etc

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
git clone https://github.com/balukarthik/Scripts $GITHUB_HOME/Scripts
git clone https://github.com/balukarthik/Notes   $GITHUB_HOME/Notes
git clone https://github.com/balukarthik/Lists   $GITHUB_HOME/Lists

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

echo "Setup Complete" 
