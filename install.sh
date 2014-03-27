#!/bin/bash

echo "Installing dotfiles. Your old files WILL be overridden. Sorry. You can find a backup of your old files in ~/.dotfiles-backup"
FILES=".bash_prompt .bashrc .gitignore .vimrc .gitconfig"
BACKUP_DIR=./backup/`date +%Y%m%d-%H%M%S`
mkdir -p ./backup
mkdir -p $BACKUP_DIR

# Copy all the files:
for FILE in ${FILES}
do
	mv ~/${FILE} $BACKUP_DIR > /dev/null
	cp ${FILE} ~/
done

echo "Configuring variables."

# In .gitconfig, replace {git_name} and {git_email}:
echo "-- What name do you want to use for git?"
read git_name

echo "-- What email do you want to use for git?"
read git_email

sed -i "s/{git_name}/$git_name/g" ~/.gitconfig
sed -i "s/{git_email}/$git_email/g" ~/.gitconfig


# In .bash_prompt replace {username}:
echo "-- What should be your default username in .bash_prompt?"
read username

sed -i "s/{username}/$username/g" ~/.bash_prompt

# In .bashrc replace ssh-usernames:
echo "-- What should be your default ssh username in .bashrc?"
read ssh_username

sed -i "s/{ssh_username}/$ssh_username/g" ~/.bashrc



echo "Configuring variables done."
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
