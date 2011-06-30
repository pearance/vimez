

# Change directory to user $HOME
cd $HOME

# Clean up any remnants of an existing Vim install
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv -f $i $i.vimez.bak; done
rm -r .vim

# Clone VimEz
git clone git://github.com/VimEz/VimEz.git .vim

# Link to vimrc and gvimrc config files
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Clone Vundle
cd .vim
git clone http://github.com/VimEz/vundle.git ~/.vim/bundle/Vundle
cd bundle/Vundle
git checkout events
vim -u initrc +BundleInstall +q

# Clean up
rm ~/install.sh
# TODO: insert 'stty -ixon' into .profile if it exist to disable Ctrl-s and Ctrl-q
# in terminal.
