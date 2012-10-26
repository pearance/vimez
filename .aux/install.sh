#!/bin/bash
#  ___ _   _ ____ _____  _    _     _       ____  _   _
# |_ _| \ | / ___|_   _|/ \  | |   | |     / ___|| | | |
#  | ||  \| \___ \ | | / _ \ | |   | |     \___ \| |_| |
#  | || |\  |___) || |/ ___ \| |___| |___ _ ___) |  _  |
# |___|_| \_|____/ |_/_/   \_\_____|_____(_)____/|_| |_|
#
# Author:         Fontaine Cook
# Maintainer:
#	Description:    VimEz installation script.
##------------------------------------------------------------------------------



# VARIABLES {{{

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



# }}}
# TITLE {{{
clear
/bin/echo -e $BD$RE$M
/bin/echo -e "                                         "
/bin/echo -e "              VimEz Install              "
/bin/echo -e "                                         "
/bin/echo -e $NO
#------------------------------------------------------------------------------



# }}}
# BACKUP {{{

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



# }}}
# DOWNLOAD VIMEZ {{{

/bin/echo -e $BD$M
/bin/echo -en "* Cloning VimEz...                   "
git clone -u git://github.com/vimez/vimez.git ~/.vim >>~/tmp/vimez.install.log 2>&1
#printf "%-19s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# CREATE LOCAL DIRECTORIES {{{

/bin/echo -e $BD$M
/bin/echo -en "* Generating .vim.local structure... "
/bin/mkdir -p ~/.vim.local/dictionaries/
/bin/mkdir -p ~/.vim.local/templates/
/bin/mkdir -p ~/.vim.local/bundle/
/bin/mkdir -p ~/.vim.local/tmp/sessions/
/bin/mkdir -p ~/.vim.local/tmp/view/
/bin/mkdir -p ~/.vim.local/tmp/backups/
/bin/mkdir -p ~/.vim.local/tmp/swaps/
/bin/mkdir -p ~/.vim.local/tmp/undos/
#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# POPULATE LOCAL DIRECTORIES

/bin/echo -e $BD$M
/bin/echo -en "* Populating .vim.local structure... "
touch ~/.vim.local/dictionaries/en.utf-8.add
/bin/cp -f ~/.vim/.aux/vimrc.local ~/.vim.local/
#printf "%${col}s"
sleep $dly
/bin/echo -e $bd$g"done"$no
#------------------------------------------------------------------------------



# }}}
# LINK TO CONFIGURATION FILES {{{

/bin/echo -e $BD$M
/bin/echo -en "* Linking to configuration files...  "

cd ~
/bin/rm -f ~/.vimrc

/bin/ln -s ~/.vim/vimrc .vimrc
/bin/ln -s ~/.vim.local/vimrc.local .vimrc.local

#printf "%-2s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# DOWNLOAD VUNDLE & INSTALL {{{

/bin/echo -e $BD$M
/bin/echo -en "* Installing plugin bundles...       "

git clone http://github.com/vimez/vundle.git ~/.vim/bundle/vundle >>~/tmp/vimez.install.log 2>&1
vim -u ~/.vim/initrc +BundleInstall "+let g:session_directory = '~/.vim.local/tmp/sessions/'" +q >>~/tmp/vimez.install.log 2>&1

/bin/rm -r ~/.vim/sessions

#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# WRAP {{{

/bin/echo -e $BD$M
/bin/echo -en "* Cleaning up...                     "

/bin/rm ~/install.sh >>~/tmp/vimez.install.log 2>&1

#printf "%${COL}s"
sleep $DLY
/bin/echo -e $BD$G"done"$NO

/bin/echo -e $BD$C"\nInstallation Complete\n\n"
/bin/echo -e "                    Happy vimming!"
#------------------------------------------------------------------------------

#vim:fdm=marker:
# }}}
