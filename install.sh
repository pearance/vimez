git clone git://github.com/vimez/vimez.git .vim
cd .vim

git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -u initrc +BundleInstall +q
