#!/bin/bash

CREATE=0
UPDATE=0
ADD=0
REMOVE=0
INSTALL=0
LIST=0
BACKUP_DIR="./backup"
INSTALL_LIST_FILE="to_install"
TMP_INSTALL_LIST_FILE="to_install_tmp"

function show_help {
    echo "-c : create an environment"
    echo "-e : select an environment"
    echo "-a : track a file"
    echo "-r : untrack a file"
    echo "-i : install an environment"
    echo "-l : list files to install"
    echo "Only -a or -i or -r argument"
    echo ""
    echo "Usage:"
    echo "1. Create an environment directory here with -c <environment>"
    echo "2. Add your file or directory in the environment using -a option to track it (in your $HOME)"
    echo "3. Use -i to symlink all your files in your system (it backups your current files automatically in your environment directory)"
    echo
    echo "Example:"
    echo "./config-files.sh -c linux"
    echo "./config-files.sh -e linux -a ~/.bashrc"
    echo "./config-files.sh -e linux -a \"~/Some\ Dir\""
    echo "./config-files.sh -e linux -i"
}

function path_without_home_path {
    home_path="/home/$USER/"
    substring=${1#$home_path}
    home_path="~/"
    substring=${substring#$home_path}
    echo $substring
}

function directory_of_file {
    substring_length=${#1}
    substring=${1%/*}
    directory_subtring_length=${#substring}
    if [ "$substring_length" == "$directory_subtring_length" ]; then
        echo "."
    else
        echo $substring
    fi
}

function create_environment {
    mkdir $ENVIRONMENT
    touch $ENVIRONMENT/$INSTALL_LIST_FILE
    echo "$ENVIRONMENT created."
}

function add {
    element_to_add=$(path_without_home_path "$1")
    if grep -Fxq "$element_to_add" $INSTALL_LIST_FILE; then
        echo "$element_to_add already added. Exiting"

        return
    fi
    echo "$element_to_add doesn't exist. Adding"
    if [ -e "./$element_to_add" ]; then
        echo "$element_to_add already exists for environment $ENVIRONMENT. Exiting"

        exit 1
    fi
    echo "Retrieving $element_to_add"
    retrieve "$element_to_add"
    echo -e "$element_to_add" >> $INSTALL_LIST_FILE
}

function retrieve {
    element_to_retrieve="$1"
    environment_pwd=`pwd`
    cd
    pwd
    cmd="rsync -aR $element_to_retrieve \"$environment_pwd\""
    echo $cmd
    eval $cmd
    cd $environment_pwd
}

function remove {
    element_to_remove=$(path_without_home_path "$1")
    if grep -Fxq "$element_to_remove" $INSTALL_LIST_FILE; then
        echo "$element_to_remove exists. Removing"
        echo "grep -Fxv \"$element_to_remove\" $INSTALL_LIST_FILE > $TMP_INSTALL_LIST_FILE"
        grep -Fxv "$element_to_remove" $INSTALL_LIST_FILE > $TMP_INSTALL_LIST_FILE
        echo "mv $TMP_INSTALL_LIST_FILE $INSTALL_LIST_FILE"
        mv $TMP_INSTALL_LIST_FILE $INSTALL_LIST_FILE
    else
        echo "$element_to_remove doesn't already exist. Exiting"

        return
    fi
}

function install_environment {
    echo "Install $ENVIRONMENT"

    if [ ! -f $INSTALL_LIST_FILE ]; then
        echo "$ENVIRONMENT is not an environment. Exiting."
        exit 1
    fi

    cat $INSTALL_LIST_FILE | while read -r element; do
        install "$element"
    done
}

function create_backup_dir {
    if [ -d $BACKUP_DIR ]; then

        return
    else
        mkdir $BACKUP_DIR
    fi
    if [ ! -d $BACKUP_DIR ]; then
        echo "$BACKUP_DIR cannot be created. Exiting."

        exit 1
    fi
}

function backup {
    element_to_backup="$1"
    environment_pwd=`pwd`
    cd
    pwd
    cmd="rsync -aR $element_to_backup \"$environment_pwd/$BACKUP_DIR\""
    echo $cmd
    eval $cmd
    cd $environment_pwd
}

function install {
    element=$1
    if [ -z "$element" ]; then
        echo "Empty element to install for environment $ENVIRONMENT"
        echo "Please remove empty lines in $ENVIRONMENT/$INSTALL_LIST_FILE. Exiting."
        exit 1
    fi

    existing_link_cmd="test -L $HOME/$element"
    if eval $existing_link_cmd; then
        echo "$HOME/$element is already a link. Skipping"

        return
    fi
    existing_element_cmd="test -e $HOME/$element"
    if eval $existing_element_cmd; then
        create_backup_dir
        echo "$HOME/$element exists. Backuping to $BACKUP_DIR/$element"
        backup "$element"
        rm_cmd="rm -r $HOME/$element"
        echo $rm_cmd
        eval $rm_cmd
    else
        echo "$element doesn't exist in system. No backup"
    fi
    link "$element"
}

function link {
    element="$1"
    target="$PWD/$element"
    link_name="$element"
    link_name_without_trailing_slash=${link_name%/}
    element_to_remove=$(path_without_home_path "$link_name_without_trailing_slash")
    directory=$(directory_of_file "$link_name_without_trailing_slash")
    global_directory=$HOME/$directory
    if [ ! -d $global_directory ]; then
        echo "Directory does not exist, creating $global_directory"
        mkdir -p $global_directory
    fi
    link_cmd="ln -s $target $HOME/$link_name_without_trailing_slash"
    echo "Creating link for $element"
    echo $link_cmd
    eval $link_cmd
}

function list {
    cat $INSTALL_LIST_FILE
}

while getopts ":c:?e:?a:?i?l?r:?" opt; do
    case $opt in
        e)
            [ $CREATE = 1 ] &&
            {
                show_help

                exit 1
            }
            UPDATE=1
            ENVIRONMENT=$OPTARG
            ;;
        c)
            [ $UPDATE = 1 ] || [ $ADD = 1 ] || [ $REMOVE = 1 ] || [ $INSTALL = 1 ] || [ $LIST = 1 ] &&
            {
                show_help

                exit 1
            }
            CREATE=1
            ENVIRONMENT=$OPTARG
            ;;
        a)
            [ $REMOVE = 1 ] || [ $INSTALL = 1 ] || [ $CREATE = 1 ] || [ $LIST = 1 ] || [ $UPDATE = 0 ] &&
            {
                show_help

                exit 1
            }
            ADD=1
            ARG=$OPTARG
            ;;
        r)
            [ $ADD = 1 ] || [ $INSTALL = 1 ] || [ $CREATE = 1 ] || [ $LIST = 1 ] || [ $UPDATE = 0 ] &&
            {
                show_help

                exit 1
            }
            REMOVE=1
            ARG=$OPTARG
            ;;
        i)
            [ $REMOVE = 1 ] || [ $ADD = 1 ] || [ $CREATE = 1 ] || [ $LIST = 1 ] || [ $UPDATE = 0 ] &&
            {
                show_help

                exit 1
            }
            INSTALL=1
            ;;
        l)
            [ $REMOVE = 1 ] || [ $ADD = 1 ] || [ $CREATE = 1 ] || [ $INSTALL = 1 ] || [ $UPDATE = 0 ] &&
            {
                show_help

                exit 1
            }
            LIST=1
            ;;
        h|\?)
            show_help

            exit 0
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2

            exit 1
            ;;
    esac
done

if [ -z $ENVIRONMENT ]; then
    show_help

    exit 0
fi

if [ $CREATE = 1 ]; then
    create_environment $ENVIRONMENT

    exit 0
fi

cd $ENVIRONMENT

if [ $ADD = 1 ]; then
    add "$ARG"
elif [ $REMOVE = 1 ]; then
    remove "$ARG"
elif [ $INSTALL = 1 ]; then
    install_environment
elif [ $LIST = 1 ]; then
    list
else
    show_help
fi
