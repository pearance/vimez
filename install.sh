

# Change directory to user $HOME
cd $HOME

# Clean up any remnants of an existing Vim install
for i in ~/.vim ~/.vimrc ~/.gvimrc; do [ -e $i ] && mv $i $i.old; done

# Clone VimEz
git clone git://github.com/vimez/vimez.git .vim

# Link to vimrc and gvimrc config files
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Clone Vundle
cd .vim
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -u initrc +BundleInstall +q
