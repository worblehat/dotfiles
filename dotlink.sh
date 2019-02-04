#!/bin/bash
# This script symlinks the files and folders in the current directory to the $HOME of the user appending a
# dot in front of the name. Files that already have a preceding dot will be ignored. 
# If the target already exists it is backuped to $HOME/.dotfiles.bck/ before overwriting it.

# Files from the repo that should not be linked:
dont_link=("./dotlink.sh" "./README.md" "./TODO.md")
# Files that are not just linked to a dotfile in $HOME:
special=("./asunder")
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

if ! ping -c 1 github.com &> /dev/null
then
    while true; do
        read -p "Can't connect to github. Continue anyway? [(y)es or (n)o]: " answer
        case $answer in
            [Yy]* )
                break
                ;;
            [Nn]* )
                exit 1
                ;;
        esac
    done
fi

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
    # Link special files 
    elif [ ${file} == "./asunder" ]
    then
        asunder_dir="${HOME}/.config/asunder"
        mkdir -p ${asunder_dir}
        link="${asunder_dir}/asunder"
        backup_file $link
        ln -s "${current_dir}/${file##*/}" $link
        echo "Linked ${link} to ${current_dir}/${file##*/}"
    fi
done

# Generate less configuration ($HOME/.less) from .lesskey
echo "Generating less configuration."
lesskey

# Include .bash_additions in .bashrc
if [ -f ~/.bashrc ]
then
    if grep -q ". ~/.bash_additions" ~/.bashrc
    then
        echo ".bashrc seems to already include .bash_additions."
    else
        echo ".bashrc does not include .bash_additions"
    fi
    while true; do
        read -p "Should .bashrc be edited to include .bash_additions? [(y)es or (n)o]: " answer
        case $answer in
            [Yy]* )
                echo "" >> ~/.bashrc 
                echo "# Include .bash_additions" >> ~/.bashrc 
                echo "if [ -f ~/.bash_additions ]; then" >> ~/.bashrc
                echo "   . ~/.bash_additions" >> ~/.bashrc 
                echo "fi" >> ~/.bashrc
                echo "" >> ~/.bashrc 
                echo ".bash_additions included."
                break
                ;;
            [Nn]* ) 
                echo ".bash_additions not included."
                break
                ;;
        esac
    done
else
    echo ".bashrc not found. .bash_additions not included."
fi

# Init git submodules
while true; do
    read -p "Should git submodules (vim plugins) be downloaded now? [(y)es or (n)o]: " answer
    case $answer in
        [Yy]* )
            echo "Initialize and update submodules...."
            git submodule update --init --recursive
            break
            ;;
        [Nn]* )
            echo "Submodules not initialized and updated."
            break
            ;;
    esac
done

# Download git-completion.sh
while true; do
    read -p "Should the git completion script for bash be downloaded and linked now? [(y)es or (n)o]: " answer
    case $answer in
        [Yy]* )
            echo "Downloading .git-completion.bash to ~..."
            wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ${HOME}/.git-completion.bash &> /dev/null
            if [ $? -ne 0 ]; then
                echo "Error: Can't download git completion script!"
                break
            fi
            echo "git completion script download finished."
            include_gc_script=true
            if grep -q ". ~/.git-completion.bash" ~/.bashrc
            then
                echo ".bashrc seems to already include git-completion.bash"
                while true; do
                    read -p "Should .bashrc be edited to include git-completion.bash? [(y)es or (n)o]: " answer
                    case $answer in
                        [Yy]* )
                            include_gc_script=true
                            break
                            ;;
                        [Nn]* ) 
                            include_gc_script=false
                            break
                            ;;
                    esac
                done
            fi
            if [ "$include_gc_script" == "true" ]
            then
                echo "" >> ~/.bashrc
                echo "# Include ./git-completion.bash" >> ~/.bashrc 
                echo "if [ -f ~/.git-completion.bash ]; then" >> ~/.bashrc
                echo "   . ~/.git-completion.bash" >> ~/.bashrc 
                echo "fi" >> ~/.bashrc
                echo "" >> ~/.bashrc 
                echo "git-completion.bash included."
            else
                echo "git-completion.bash not included."
            fi
            break
            ;;
        [Nn]* )
            echo "Git completion script not downlaoded."
            break
            ;;
    esac
done

echo "Finished."
