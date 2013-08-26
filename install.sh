#!/bin/bash

echo "Installing dotfiles. Your old files WILL be overridden. Sorry."

# Delete unnecessary files:
mv .bash_prompt ~/
mv .bashrc ~/
mv .gitignore ~/
mv .vimrc ~/

rm README.md
rm install.sh

dirname=${PWD##*/} # Get current directory name
cd ..
rmdir $dirname

echo "Setting up ~/.vim directories"

# Set up vim directories and install Pathogen:
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo "Finished!"
