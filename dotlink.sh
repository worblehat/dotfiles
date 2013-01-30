#!/bin/bash
# This script symlinks the files and folders in the current directory to the $HOME of the user appending a
# dot in front of the name. Files that already have a preceding dot will be ignored. 
# If the target already exists it is backuped to $HOME/.dotfiles.bck/ before overwriting it.

backup_dir="${HOME}/.dotfiles.bck"
current_dir=`pwd -P`
date=$(/bin/date +%Y-%m-%d_%H-%M-%S)

# Iterate over all non-dot-files 
for file in ./* 
do
    # Ommit this script and the README
    if [ "$file" != "./dotlink.sh" ]  && [ "$file" != "./README.md" ]
    then
        link="${HOME}/.${file##*/}"
        # If there already is something move it to the backup dir
        if [ -f $link ] || [ -d $link ] || [ -L $link ]
        then
			mkdir -p $backup_dir
			cp -R --no-dereference --preserve $link "${backup_dir}/${link##*/}.${date}"
			rm $link
			echo "Moved ${link} to ${backup_dir}/${link##*/}.${date}"
		fi
        # Create the symlink
        ln -s "${current_dir}/${file##*/}" $link 
        echo "Linked ${link} to ${current_dir}/${file##*/}"
    fi
done
