#!/bin/bash

echo "Installing dotfiles. Your old files WILL be overridden. Sorry. You can find a backup of your old files in ~/.dotfiles-backup"
FILES=".bash_prompt .bashrc .gitignore .vimrc .gitconfig"
BACKUP_DIR=~/.dotfiles-backup-`date +%Y%m%d-%H%M%S`
mkdir -p $BACKUP_DIR

# Copy all the files:
for FILE in ${FILES}
do
	mv ~/${FILE} $BACKUP_DIR > /dev/null
	cp ${FILE} ~/
done

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
