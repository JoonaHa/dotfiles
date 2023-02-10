# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

if [ -n "$DISPLAY" ]; then
    export BROWSER="firefox-nightly"
else 
    export BROWSER="links"
fi
export EDITOR="vim"
export VISUAL="nvim"
export SHELL=/bin/zsh
# Flutter PATH
export PATH=/home/mina/flutter/bin:$PATH

#Gradle PATH
export PATH=/home/mina/gradle/gradle-3.3/bin:$PATH

export PATH="$HOME/.cargo/bin:$PATH"

export PATH=~/node-v10.15.0-linux-x64/bin:$PATH

export NXJ_HOME=/home/mina/JohTek/leJOS_NXJ_0.9.1beta-3
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH


#Node user
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

export MANGOHUD=1
# Nvidia env's
#export __GL_THREADED_OPTIMIZATIONS=1
#export LD_PRELOAD="libpthread.so.0 libGL.so.1"

# Use bat for manuals
# MANROFFOPT for ANSI escapes https://github.com/sharkdp/bat/issues/652#issuecomment-529032263
export MANROFFOPT="-c"; export MANPAGER="sh -c 'col -bx | bat -pl man'"

export QT_QPA_PLATFORMTHEME=qt5ct

alias enchant='enchant-2'

