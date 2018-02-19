#!/bin/bash

BACKUP_DIR=~/.dotfiles-backup/`date +%Y%m%d-%H%M%S`
FILES=".bash_prompt .bashrc .gitignore .vimrc .gitconfig"

if [ ! -f ./env.sh ]; then
	echo "Copy env.sh.example to env.sh and edit it before continuing"
	exit 1
fi

source ./env.sh

echo "Installing dotfiles. Your old files WILL be overridden. Sorry. You can find a backup of your old files in ~/.dotfiles-backup"
mkdir -p $BACKUP_DIR

# Copy all the files:
for FILE in ${FILES}
do
	mv ~/${FILE} $BACKUP_DIR > /dev/null
	cp ${FILE} ~/
done

echo "Configuring variables"

# In .gitconfig, replace {git_name} and {git_email}:
sed -i "s/{git_name}/$DOT_GIT_NAME/g" ~/.gitconfig
sed -i "s/{git_email}/$DOT_GIT_EMAIL/g" ~/.gitconfig

# In .bash_prompt replace {username}:
sed -i "s/{username}/$(whoami)/g" ~/.bash_prompt

echo "Setting up ~/.vim directories"

# Set up vim directories and install Pathogen:
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Let's also install some nice vim plugins I'd want to install anyway:
echo "Installing VIM plugins"
git clone git@github.com:vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone git@github.com:vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
git clone git@github.com:altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
git clone git@github.com:airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter

echo "Finished!"

