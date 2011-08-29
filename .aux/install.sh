#!/bin/bash
#------------------------------------------------------------------------------
# Title:          .install.sh (VimEz)
#	Description:    VimEz installation script.
# Author:         Fontaine Cook <fontaine.cook@pearance.com>
# Maintainer:     Fontaine Cook <fontaine.cook@pearance.com>
#	Last Modified:  08/08/2011
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
/bin/echo -e "                                       "
/bin/echo -e "             VimEz Install             "
/bin/echo -e "                                       "
/bin/echo -e $NO
#------------------------------------------------------------------------------



# Backup any remnants of an existing Vim install.
/bin/echo -e $BD$M
/bin/echo -en "* Backing up existing Vim install... "
cd ~
/bin/mkdir -p ~/tmp
if [ -f ~/tmp/vimez.install.log ]; then
  /bin/rm ~/tmp/vimez.install.log
fi
/bin/rm -fr ~/backup/vimez/
/bin/mkdir -p ~/backup/vimez/
for i in .vimrc .gvimrc .vim
  do [ -e $i ] && /bin/mv -f $i backup/vimez/$i
done
#printf "%-0s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Clone VimEz
/bin/echo -e $BD$M
/bin/echo -en "* Cloning VimEz...                   "
git clone git://github.com/VimEz/VimEz.git ~/.vim >>~/tmp/vimez.install.log 2>&1
#printf "%-19s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Link to vimrc and gvimrc configuration files.
/bin/echo -e $BD$M
/bin/echo -en "* Linking to configuration files...  "
cd ~
/bin/rm -f ~/.vimrc
/bin/rm -f ~/.gvimrc
/bin/ln -s .vim/vimrc .vimrc
/bin/ln -s .vim/gvimrc .gvimrc
#printf "%-2s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Create .vim.local structure.
/bin/echo -e $BD$M
/bin/echo -en "* Generating .vim.local structure... "
/bin/mkdir -p ~/.vim.local/sessions/
/bin/mkdir -p ~/.vim.local/spell/
/bin/mkdir -p ~/.vim.local/tmp/backups/
/bin/mkdir -p ~/.vim.local/tmp/swaps/
/bin/mkdir -p ~/.vim.local/tmp/undos/
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Populate .vim.local structure.
/bin/echo -e $BD$M
/bin/echo -en "* Populating .vim.local structure... "
touch ~/.vim.local/spell/en.utf-8.add
/bin/cp -f ~/.vim/.aux/initrc.local.example ~/.vim.local/
/bin/cp -f ~/.vim/.aux/vimrc.local.example ~/.vim.local/
/bin/cp -f ~/.vim/.aux/gvimrc.local.example ~/.vim.local/
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Clone Vundle and install plugin/bundles.
/bin/echo -e $BD$M
/bin/echo -en "* Installing plugin bundles...       "
git clone http://github.com/VimEz/Vundle.git ~/.vim/bundle/Vundle >>~/tmp/vimez.install.log 2>&1
vim -u ~/.vim/initrc +BundleInstall "+let g:session_directory = '~/.vim.local/sessions/'" +q >>~/tmp/vimez.install.log 2>&1
/bin/rm -r ~/.vim/sessions
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Install Command-T C extension.
/bin/echo -e $BD$M
/bin/echo -en "* Compiling Command-T extensions...  "
rvm use system >>~/tmp/vimez.install.log 2>&1
cd ~/.vim/bundle/Command-T/ruby/command-t/
ruby extconf.rb >>~/tmp/vimez.install.log 2>&1
make >>~/tmp/vimez.install.log 2>&1
cd ~
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Clean up.
/bin/echo -e $BD$M
/bin/echo -en "* Cleaning up...                     "
/bin/rm ~/install.sh >>~/tmp/vimez.install.log 2>&1
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"ok"$NO
#------------------------------------------------------------------------------



# Outro
/bin/echo -e $BD$C"\nInstallation Complete\n\n"
/bin/echo -e "                    Happy vimming!"
