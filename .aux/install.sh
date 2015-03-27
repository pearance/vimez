#!/bin/bash
# vim:fdm=marker:
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
#------------------------------------------------------------------------------

# }}}
# BACKUP CONFIGURATION {{{

/bin/rm -rf /tmp/vimez.install.log
/bin/rm -rf ~/backups/pre-vimez/ &&  /bin/mkdir -p ~/backups/pre-vimez/

for i in .vimrc .gvimrc .vim
	do [ -e $i  ] && mv -f --backup=t $i ~/backups/pre-vimez/$i.bak
done

/bin/rm -rf .vim .vimrc .viminfo .gvimrc
/bin/echo -en "Backup existing Vim install... done"
#------------------------------------------------------------------------------

# }}}
# UNINSTALL EXISTING VIM {{{

sudo aptitude remove -y \
	vim vim-runtime gvim vim-tiny vim-common vim-gui-common

/bin/echo -en "Uninstall existing Vim install... done "
#------------------------------------------------------------------------------

# }}}
# INSTALL DEPENDENCIES {{{

sudo aptitude install -y \
	libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev \
	libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev libxtst-dev \
	build-essential python-dev ruby-dev mercurial checkinstall

/bin/echo -en "Install dependencies... done"
#------------------------------------------------------------------------------

# }}}
# BUILD VIM {{{
sudo aptitude purge vim

if [ -d "~/src/vim" ]; then
	cd ~/src/vim
	hg update
else
	hg clone https://vim.googlecode.com/hg/ ~/src/vim
fi

cd ~/src/vim

# terminal config
./configure \
	--enable-rubyinterp=dynamic \
	--enable-perlinterp=dynamic \
	--enable-pythoninterp=dynamic \
	--with-python-config-dir=/usr/lib/python2.7/config \
	--enable-cscope \
	--enable-gui=auto \
	--enable-gtk2-check
	--enable-gnome-check \
	--with-features=huge \
	--with-x \
	--with-compiledby="Fontaine Cook <fontaine.cook@pearance.com>"

sudo make

sudo checkinstall

sudo make clean

/bin/echo -en "Build Vim... done"
#------------------------------------------------------------------------------

# }}}
# DOWNLOAD VIMEZ {{{

git clone https://github.com/vimez/vimez.git ~/.vim

/bin/echo -en "Clone Vimez... done"
#------------------------------------------------------------------------------

# }}}
# SETUP LOCAL FILES {{{

/bin/mkdir -p ~/dotfiles/
/bin/mkdir -p ~/dotfiles/vim.local/dictionaries/
/bin/mkdir -p ~/dotfiles/vim.local/snippets/
/bin/mkdir -p ~/dotfiles/vim.local/templates/
/bin/mkdir -p ~/dotfiles/vim.local/bundle/
/bin/mkdir -p ~/dotfiles/vim.local/tmp/view/
/bin/mkdir -p ~/dotfiles/vim.local/tmp/backups/
/bin/mkdir -p ~/dotfiles/vim.local/tmp/swaps/
/bin/mkdir -p ~/dotfiles/vim.local/tmp/undos/

touch ~/dotfiles/vim.local/dictionaries/en.utf-8.add
/bin/cp  ~/.vim/.aux/vimrc.local.template ~/dotfiles/vim.local/

/bin/echo -en "Setup local files... done"
#------------------------------------------------------------------------------

# }}}
# DOWNLOAD VUNDLE & INSTALL {{{

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cd ~
/bin/ln -sf .vim/vimrc .vimrc
vim +BundleInstall +qall

/bin/echo -en "5 Installing plugin bundles... done"
#------------------------------------------------------------------------------

# }}}
# WRAP {{{

/bin/rm ~/install.sh
/bin/rm f ~/yankring_history_v2.txt


/bin/echo -e $BD$C"\nInstallation Complete\n\n"
/bin/echo -e "                    Happy vimming!"
/bin/echo
/bin/echo

/bin/echo -en "Cleaning up... done"
#------------------------------------------------------------------------------

# }}}
