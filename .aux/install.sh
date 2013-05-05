#vim:fdm=marker:
#!/bin/bash
#        _
# __   _(_)_ __ ___   ___ ____
# \ \ / / | '_ ` _ \ / _ \_  /
#  \ V /| | | | | | |  __// /
#   \_/ |_|_| |_| |_|\___/___|
#  _           _        _ _       _
# (_)_ __  ___| |_ __ _| | |  ___| |__
# | | '_ \/ __| __/ _` | | | / __| '_ \
# | | | | \__ \ || (_| | | |_\__ \ | | |
# |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
#
# Author:         Fontaine Cook
# Description:    Vimez installation script.
# ------------------------------------------------------------------------------



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
/bin/echo -e $BD$G"Note: step 6 can take up to three minutes"$NO
/bin/echo -e $BD$G"to complete. Please be patient."$NO

#------------------------------------------------------------------------------



# }}}
# BACKUP {{{
# Backup any remnants of an existing Vim install.
/bin/echo -e $BD$M
/bin/echo -en "1 Backing up existing Vim install... "

/bin/rm -rf /tmp/vimez.install.log
/bin/rm -rf ~/backups/pre-vimez/ &&  /bin/mkdir -p ~/backups/pre-vimez/

for i in .vimrc .gvimrc .vim .vim.local
	do [ -e $i  ] && mv -f --backup=t $i ~/backups/pre-vimez/$i.bak
done

sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# DOWNLOAD VIMEZ {{{
/bin/echo -e $BD$M
/bin/echo -en "2 Cloning Vimez...                   "

git clone git://github.com/vimez/vimez.git ~/.vim >>/tmp/vimez.install.log 2>&1
sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# CREATE LOCAL DIRECTORIES {{{
/bin/echo -e $BD$M
/bin/echo -en "3 Generating .vim.local structure... "

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
/bin/echo -en "4 Populating .vim.local structure... "

touch ~/.vim.local/dictionaries/en.utf-8.add
/bin/cp  ~/.vim/.aux/vimrc.local ~/.vim.local/vimrc.local

sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# LINK TO CONFIGURATION FILES {{{
/bin/echo -e $BD$M
/bin/echo -en "5 Linking to configuration files...  "

cd ~
/bin/rm -f .vimrc
/bin/ln -s .vim/vimrc .vimrc
/bin/ln -s .vim.local/vimrc.local .vimrc.local

sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# DOWNLOAD VUNDLE & INSTALL {{{
/bin/echo -e $BD$M
/bin/echo -en "6 Installing plugin bundles...       "

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle >>/tmp/vimez.install.log 2>&1
vim -u ~/.vim/initrc +BundleInstall "+let g:session_directory = '~/.vim.local/tmp/sessions/'" +qall >>/tmp/vimez.install.log 2>&1
/bin/rm -r ~/.vim/sessions

sleep $DLY
/bin/echo -e $BD$G"done"$NO
#------------------------------------------------------------------------------



# }}}
# WRAP {{{
/bin/echo -e $BD$M
/bin/echo -en "7 Cleaning up...                     "

/bin/rm ~/install.sh >>/tmp/vimez.install.log 2>&1

sleep $DLY
/bin/echo -e $BD$G"done"$NO

/bin/echo -e $BD$C"\nInstallation Complete\n\n"
/bin/echo -e "                    Happy vimming!"
/bin/echo
/bin/echo
/bin/echo -e "You can view the install log at /tmp/vimez.install.log"
#------------------------------------------------------------------------------



# }}}
