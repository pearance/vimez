#!/bin/bash
#  ___ _   _ ____ _____  _    _     _       ____  _   _
# |_ _| \ | / ___|_   _|/ \  | |   | |     / ___|| | | |
#  | ||  \| \___ \ | | / _ \ | |   | |     \___ \| |_| |
#  | || |\  |___) || |/ ___ \| |___| |___ _ ___) |  _  |
# |___|_| \_|____/ |_/_/   \_\_____|_____(_)____/|_| |_|
#
# Author:         Fontaine Cook
# Maintainer:
#	Description:    Vimez installation script.
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
/bin/echo -e "                                            "
/bin/echo -e "              Vimez Install                 "
/bin/echo -e "                                            "
/bin/echo -e $NO
#------------------------------------------------------------------------------



# }}}
# BACKUP {{{
# Backup any remnants of an existing Vim install.
/bin/echo -e $BD$M
/bin/echo -en "* Backing up existing Vim install... "

/bin/rm -rf ~/backups/pre-vimez/ && /bin/mkdir -p ~/backups/pre-vimez/

for i in .vimrc .gvimrc .vim .vim.local
	do [ -e $i  ] && mv -f --backup=t $i ~/backups/pre-vimez/$i.bak
done

sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# DOWNLOAD VIMEZ {{{
/bin/echo -e $BD$M
/bin/echo -en "* Cloning Vimez...                   "
git clone git://github.com/vimez/vimez.git ~/.vim
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# CREATE LOCAL DIRECTORIES {{{
/bin/echo -e $BD$M
/bin/echo -en "* Generating .vim.local structure... "
mkdir -p ~/.vim.local
/bin/mkdir -p ~/.vim.local/dictionaries/
/bin/mkdir -p ~/.vim.local/templates/
/bin/mkdir -p ~/.vim.local/bundle/
/bin/mkdir -p ~/.vim.local/tmp/sessions/
/bin/mkdir -p ~/.vim.local/tmp/view/
/bin/mkdir -p ~/.vim.local/tmp/backups/
/bin/mkdir -p ~/.vim.local/tmp/swaps/
/bin/mkdir -p ~/.vim.local/tmp/undos/
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# POPULATE LOCAL DIRECTORIES {{{
/bin/echo -e $BD$M
/bin/echo -en "* Populating .vim.local structure... "
touch ~/.vim.local/dictionaries/en.utf-8.add
/bin/cp  ~/.vim/.aux/vimrc.local ~/.vim.local/vimrc.local
sleep $dly
/bin/echo -e $bd$g"done"$no
#------------------------------------------------------------------------------



# }}}
# LINK TO CONFIGURATION FILES {{{
/bin/echo -e $BD$M
/bin/echo -en "* Linking to configuration files...  "

cd ~
/bin/rm -f .vimrc
/bin/ln -s .vim/vimrc .vimrc
/bin/ln -s .vim.local/vimrc.local .vimrc.local

sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# DOWNLOAD VUNDLE, THEMES, & INSTALL {{{
/bin/echo -e $BD$M
/bin/echo -en "* Installing plugin bundles...       "

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/vimez/vim-themes.git ~/.vim/bundle/vim-themes
vim +BundleInstall "+let g:session_directory = '~/.vim.local/tmp/sessions/'" +qall

/bin/rm -r ~/.vim/sessions

sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# WRAP {{{
/bin/echo -e $BD$M
/bin/echo -en "* Cleaning up...                     "

/bin/rm ~/install.sh

sleep $DLY
/bin/echo -e $BD$G"done"$NO

/bin/echo -e $BD$C"\nInstallation Complete\n\n"
/bin/echo -e "                    Happy vimming!"
#------------------------------------------------------------------------------

# }}}
#vim:fdm=marker:
