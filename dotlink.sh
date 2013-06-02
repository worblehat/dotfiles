#!/bin/bash
# This script symlinks the files and folders in the current directory to the $HOME of the user appending a
# dot in front of the name. Files that already have a preceding dot will be ignored. 
# If the target already exists it is backuped to $HOME/.dotfiles.bck/ before overwriting it.

# Files from the repo that should not be linked:
dont_link=("./dotlink.sh" "./README.md")
# Files that are not just linked to a dotfile in $HOME:
special=("./MyShell.profile")
# Directory for file backups:
backup_dir="${HOME}/.dotfiles.bck"

current_dir=`pwd -P`
date=$(/bin/date +%Y-%m-%d_%H-%M-%S)

function backup_file() {
    # :param $1: file to backup
    local file=$1
    # If the file/directory/symlink already exists move it to the backup dir
    if [ -f $file ] || [ -d $file ] || [ -L $file ]
    then
        mkdir -p $backup_dir
        cp -R --no-dereference --preserve $file "${backup_dir}/${file##*/}.${date}"
        rm -r $file
        echo "Moved ${file} to ${backup_dir}/${file##*/}.${date}"
    fi
}

# Iterate over all non-dot-files 
for file in ./* 
do
    # Ommit file that should not be linked 
    if [[ ! ${dont_link[*]} =~ ${file} ]] && [[ ! ${special[*]} =~ ${file} ]]
    then
        link="${HOME}/.${file##*/}"
        backup_file $link
        # Create the symlink
        ln -s "${current_dir}/${file##*/}" $link 
        echo "Linked ${link} to ${current_dir}/${file##*/}"
    # Some special cases:
    elif [ ${file} == "./MyShell.profile" ]
    then    
        # What's the kde directory?
        if [ -d "${HOME}/.kde" ]
        then
            kde_dir="${HOME}/.kde"
        elif [ -d "${HOME}/.kde4" ]
        then
            kde_dir="${HOME}/.kde4"
        fi
        if [ -n "${kde_dir}" ]
        then
            # Check if KDE Konsole is installed 
            konsole_dir="${kde_dir}/share/apps/konsole/"
            if [ -d $konsole_dir ]
            then
                # Link the profile file in the konsole's directory
                link="${konsole_dir}MyShell.profile" 
                backup_file $link
                ln -s "${current_dir}/${file##*/}" $link 
                echo "Linked ${link} to ${current_dir}/${file##*/}"
            fi
        fi
    fi
done
