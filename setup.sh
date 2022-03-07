#!/bin/bash

# If we see this script that means we this directory
SETUP_DIR="$HOME/github/balukarthik/Setup/"

# Copy setup.sh to home directory and change 
cp $SETUP_DIR/setup.sh $HOME
chmod u+x $HOME/setup.sh

# Copy environment setting file to home directory and run it
cp $SETUP_DIR/env.sh $HOME
chmod u+x $HOME/env.sh
source $HOME/env.sh

# Set environment variables upon startup
if grep -Fxq "source \$HOME/env.sh" $HOME/.bashrc
then 
   # Nothing to be done here
   :
else
   echo 'source $HOME/env.sh' >> $HOME/.bashrc
fi

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

echo "Setup Complete" 
