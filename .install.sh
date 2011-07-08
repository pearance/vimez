#!/bin/bash

# Backup any remnants of an existing Vim install
for i in ~/.vim ~/.vimrc ~/.gvimrc
  do [ -e $i ] && mv -f $i $i.vimez.bak
done
rm -f ~/.vimrc
rm -f ~/.gvimrc
echo -e "\nBackedup existing Vim install successfully\n"



# Clone VimEz
git clone git://github.com/VimEz/VimEz.git ~/.vim
echo -e "\nCloned VimEz successfully!\n"



# Link to vimrc and gvimrc config files
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
echo -e "\nLinked to configuration files successfully!\n"



# Clone Vundle and install plugin/bundles
git clone http://github.com/VimEz/vundle.git ~/.vim/bundle/vundle
vim -u ~/.vim/initrc +BundleInstall +q
echo -e "\nPlugin bundles installed successfully!\n"



# Install Command-T C extension
echo -e "\n"
rvm use system
cd ~/.vim/bundle/Command-T/ruby/command-t/ 
ruby extconf.rb
make
cd
echo -e "\nCompiled Command-T C extension successfully\n"



# Clean up
rm ~/.install.sh
rm ~/.vim/install.sh
echo -e "\nCleaned up successfully\n"


# TODO: insert 'stty -ixon' into .profile if it exist to disable Ctrl-s and Ctrl-q
# in terminal.
