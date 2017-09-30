#!/bin/bash

# .vimrc and .bashrc and .gitconfig file
# save all in ~

# plugins with Vundle, requires Vim 8.0
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# follow rest of instructions on Vundle quick setup page

# You might need to upgrade to Vim 8.0!
# Check out http://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/
# It's not bad at all

# for colors:
shell``` 
mkdir ~/.vim/colors/
cd ~/.vim/colors
wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim

cd ~
cp vimrc/.vimrc .vimrc
cp vimrc/.bashrc .bashrc
```
