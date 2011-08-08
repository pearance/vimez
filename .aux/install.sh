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



# Color codes.
NO="\033[0;39m"
BD="\033[1;39m"
UN="\033[4;39m"
RE="\033[7;39m"
R="\033[31m"
G="\033[32m"
Y="\033[33m"
B="\033[34m"
M="\033[35m"
C="\033[36m"
W="\033[37m"
#------------------------------------------------------------------------------



# Establish "Grand" Title.
clear
/bin/echo -e $BD$M
/bin/echo "*************************************"
/bin/echo "*           VimEz Install           *"
/bin/echo "*************************************"
/bin/echo -e $BD$B
#------------------------------------------------------------------------------



# Backup any remnants of an existing Vim install.
cd ~
/bin/rm -fr ~/backup/vimez/
/bin/mkdir -p ~/backup/vimez/
for i in .vimrc .gvimrc .vim
  do [ -e $i ] && /bin/mv -f $i backup/vimez/$i
done
/bin/echo -e $BD$RE$M
/bin/echo -e "\nBackedup existing Vim install successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------



# Clone VimEz
git clone git://github.com/VimEz/VimEz.git ~/.vim
/bin/echo -e $BD$UN$M
/bin/echo -e "\nCloned VimEz successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------



# Link to vimrc and gvimrc configuration files.
cd ~
/bin/rm -f ~/.vimrc
/bin/rm -f ~/.gvimrc
/bin/ln -s .vim/vimrc .vimrc
/bin/ln -s .vim/gvimrc .gvimrc
/bin/echo -e $BD$UN$M
/bin/echo -e "\nLinked to configuration files successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------



# Clone Vundle and install plugin/bundles.
git clone http://github.com/VimEz/Vundle.git ~/.vim/bundle/Vundle
vim -u ~/.vim/initrc +BundleInstall +q
/bin/echo -e $BD$UN$M
/bin/echo -e "\nPlugin bundles installed successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------



# Install Command-T C extension.
/bin/echo -e "\n"
rvm use system
/bin/echo -e "\n"
cd ~/.vim/bundle/Command-T/ruby/command-t/
ruby extconf.rb
make
cd
/bin/echo -e $BD$UN$M
/bin/echo -e "\nCompiled Command-T C extension successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------



# Create local directories.
/bin/mkdir -p ~/.vim.local/sessions/
/bin/mkdir -p ~/.vim.local/spell/
/bin/mkdir -p ~/.vim.local/tmp/backups/
/bin/mkdir -p ~/.vim.local/tmp/swaps/
/bin/mkdir -p ~/.vim.local/tmp/undos/
/bin/echo -e $BD$UN$M
/bin/echo -e "\nLocal directories created successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------



# Populate local directories.
touch ~/.vim.local/spell/en.utf-8.add
/bin/cp -f ~/.vim/.aux/initrc.local.example ~/.vim.local/
/bin/cp -f ~/.vim/.aux/vimrc.local.example ~/.vim.local/
/bin/cp -f ~/.vim/.aux/gvimrc.local.example ~/.vim.local/
/bin/echo -e $BD$UN$M
/bin/echo -e $BD$UN$M"\nLocal directories populated successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------



# Checkout plugin versions.
#/bin/mv ~/.vim/bundle/ConqueShell/doc/tags ~/.vim.local/tmp/
#cd ~/.vim/bundle/ConqueShell/; git checkout 2.0; cd ~/.vim
#/bin/mv ~/.vim.local/tmp/tags ~/.vim/bundle/ConqueShell/doc/
#------------------------------------------------------------------------------



# Clean up.
/bin/rm ~/install.sh
/bin/echo -e $BD$UN$M
/bin/echo -e "\nCleaned up successfully!\n"
/bin/echo -e $NO$B
#------------------------------------------------------------------------------
