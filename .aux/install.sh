#!/bin/bash
#------------------------------------------------------------------------------
# Title:          .install.sh (VimEz)
#	Description:    VimEz installation script.
# Author:         Fontaine Cook <fontaine.cook@pearance.com>
# Maintainer:     Fontaine Cook <fontaine.cook@pearance.com>
#	Last Modified: Mon Oct 22, 2012  01:53PM
#
#	Copyright 2011 Pearance LLC.
#
#	This program is free software; you can redistribute it and/or
#	modify it under the terms of the GNU General Public License as
#	published by the Free Software Foundation.
#
#	This program is distributed in the hope that it will be useful, but
#	WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#	General Public License for more details.
#------------------------------------------------------------------------------



# Declare variables.
NO="\033[0;39m"
BD="\033[1;39m"
RE="\033[4;39m"
RE="\033[7;39m"
R="\033[31m"
G="\033[32m"
Y="\033[33m"
B="\033[34m"
M="\033[35m"
C="\033[36m"
W="\033[37m"

DLY=1
#------------------------------------------------------------------------------



# Establish "Grand" Title.
clear
/bin/echo -e $BD$RE$M
/bin/echo -e "                                         "
/bin/echo -e "              VimEz Install              "
/bin/echo -e "                                         "
/bin/echo -e $NO
#------------------------------------------------------------------------------



# Backup any remnants of an existing Vim install.
/bin/echo -e $BD$M
/bin/echo -en "* Backing up existing Vim install... "

cd ~

if [ -e ~/tmp/vimez.install.log ]; then
  /bin/rm ~/tmp/vimez.install.log
fi
/bin/mkdir -p ~/tmp

if [ -e ~/backup/vimez/]; then
  /bin/rm -fr ~/backup/vimez/
fi
/bin/mkdir -p ~/backup/vimez/

if [ -e ~/.vimrc ]; then
  /bin/mv -f ~/.vimrc backup/vimez/
fi

if [ -e ~/.gvimrc ]; then
  /bin/mv -f ~/.gvimrc backup/vimez/
fi

if [ -e ~/.vim ]; then
  /bin/mv -f ~/.vim backup/vimez/
fi

#printf "%-0s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# Clone VimEz
/bin/echo -e $BD$M
/bin/echo -en "* Cloning VimEz...                   "
git clone -u git://github.com/vimez/vimez.git ~/.vim >>~/tmp/vimez.install.log 2>&1
#printf "%-19s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# Create .vim.local structure.
/bin/echo -e $BD$M
/bin/echo -en "* Generating .vim.local structure... "
/bin/mkdir -p ~/.vim.local/data/
/bin/mkdir -p ~/.vim.local/sessions/
/bin/mkdir -p ~/.vim.local/spell/
/bin/mkdir -p ~/.vim.local/view/
/bin/mkdir -p ~/.vim.local/tmp/backups/
/bin/mkdir -p ~/.vim.local/tmp/swaps/
/bin/mkdir -p ~/.vim.local/tmp/undos/
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# Populate .vim.local structure.
/bin/echo -e $BD$M
/bin/echo -en "* Populating .vim.local structure... "
touch ~/.vim.local/spell/en.utf-8.add
/bin/cp -f ~/.vim/.aux/initrc.local ~/.vim.local/
/bin/cp -f ~/.vim/.aux/vimrc.local ~/.vim.local/
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# Link to configuration files.
/bin/echo -e $BD$M
/bin/echo -en "* Linking to configuration files...  "
cd ~
for i in .vimrc
  do [ -e $i ] && /bin/rm -f ~/$i
done

/bin/ln -s .vim/vimrc .vimrc
/bin/ln -s .vim.local/vimrc.local .vimrc.local
/bin/ln -s .vim.local/initrc.local .initrc.local

#printf "%-2s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# Clone Vundle and install plugin/bundles.
/bin/echo -e $BD$M
/bin/echo -en "* Installing plugin bundles...       "
git clone http://github.com/vimez/vundle.git ~/.vim/bundle/vundle >>~/tmp/vimez.install.log 2>&1
vim -u ~/.vim/initrc +BundleInstall "+let g:session_directory = '~/.vim.local/sessions/'" +q >>~/tmp/vimez.install.log 2>&1
/bin/rm -r ~/.vim/sessions
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# Clean up.
/bin/echo -e $BD$M
/bin/echo -en "* Cleaning up...                     "
/bin/rm ~/install.sh >>~/tmp/vimez.install.log 2>&1
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# Outro
/bin/echo -e $BD$C"\nInstallation Complete\n\n"
/bin/echo -e "                    Happy vimming!"
