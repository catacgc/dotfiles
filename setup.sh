#!/usr/bin/env sh

target="~/.vim`date +F'%Y%m%dw'`"
mkdir -p $target
mv ~/.vim $target
mv ~/.vimrc $target

ln -s `pwd`/.vimrc ~/
ln -s `pwd`/.vim ~/

git clone http://github.com/gmarik/vundle.git .vim/bundle/vundle
vim +BundleInstall +quitall
