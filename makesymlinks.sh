#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                  # dotfiles directory
olddir=~/dotfiles_old           # old dotfiles backup directory
vimbackupdir=~/.vimbackup
# list of files/folders to symlink in homedir
files="bashrc zlogin zshrc vimrc vim gitconfig tmux.conf gemrc"

##########

mkdir -p $vimbackupdir            # create vim backup dir
# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"
# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"
# Update git submodules
echo -n "Updating git submodules"
git submodule init && git submodule update
echo -n "done"
echo -n "Installing and updating vim plugins"
vim +PluginInstall! +qall
echo -n "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done
