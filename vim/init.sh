#!/bin/sh

mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim

vim -c PluginInstall -c q -c q

cd ~/.vim/bundle/YouCompleteMe
./install.py

cd ~/.vim/bundle/vim-jsx/after/ftplugin
echo "set commentstring={/*\ %s\ */}" >> jsx.vim
