#!/bin/bash

CREATE=0
UPDATE=0
ADD=0
REMOVE=0
INSTALL=0
BACKUP_DIR="./backup"
INSTALL_LIST_FILE="to_install"

function show_help {
	echo "-c : create an environment"
	echo "-e : select an environment"
	echo "-a : track a file"
	echo "-r : untrack a file"
	echo "-i : install an environment"
	echo "Only -a or -i or -r argument"
	echo ""
	echo "Usage:"
	echo "1. Create an environment directory here with -c <environment>"
	echo "2. Add your file or directory in the environment using -a option to track it (relative path in /home/$USER)"
	echo "3. Use -i to symlink it in your system (it backups your current files automatically in your environment directory)"
	echo
	echo "Example:"
	echo "./config-files.sh -c linux"
	echo "./config-files.sh -e linux -a .bashrc"
	echo "./config-files.sh -e linux -i"
}

function create {
	mkdir $ENVIRONMENT
	touch $ENVIRONMENT/$INSTALL_LIST_FILE
}

function check_existence_of_element_in_list {
	element_to_add=$1
	elements=`cat $INSTALL_LIST_FILE`
	for element in $elements; do
		if [ $element = $element_to_add ]; then
			echo 1
			return
		fi
	done
	echo 0
}

function add {
	element_to_add=$1
	existing_element=$(check_existence_of_element_in_list $element_to_add)
	if [[ "$existing_element" = 1 ]]; then
		echo "$element_to_add already added. Exiting"
		return
	else
		echo "$element_to_add doesn't exist. Adding"
		if [ -e ./$element_to_add ]; then
			echo "$element_to_add already exists for this environment ($ENVIRONMENT). Exiting"
			exit 1
		fi
		echo "cp -r $HOME/$element_to_add ."
		cp $HOME/$element_to_add .
		echo -e "$element_to_add" >> $INSTALL_LIST_FILE
	fi
}

function remove {
	element_to_remove=$1
	existing_element=$(check_existence_of_element_in_list $element_to_remove)
	if [[ "$existing_element" = 1 ]]; then
		echo "$element_to_remove exists. Removing"
		sed -i /^$element_to_remove$/d $INSTALL_LIST_FILE
	else
		echo "$element_to_remove doesn't already exist. Exiting"
		return
	fi
}

function install_environment {
	echo "Install $ENVIRONMENT"

	elements=`cat $INSTALL_LIST_FILE`
	for element in $elements; do
		install $element
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
	element=$1
	echo "cp -r --parents $HOME/$element $BACKUP_DIR"
	cp -r --parents $HOME/$element $BACKUP_DIR
	if [ ! -e $BACKUP_DIR/$HOME/$element ]; then
		echo "$element cannot be backuped. Exiting."
		exit 1
	fi
}

function install {
	element=$1
	if [ -L $HOME/$element ]; then
		echo "$HOME/$element is already a link. Skipping"
		return
	fi
	if [ -e $HOME/$element ]; then
		create_backup_dir
		echo "$HOME/$element exists. Backuping to $BACKUP_DIR/$element"
		backup $element
		echo "rm -r $HOME/$element"
		rm -r $HOME/$element
	else
		echo "$element doesn't exist in system. No backup"
	fi
	link $element
}

function link {
	element=$1
	target=$PWD/$element
	link_name=$element
	echo "Creating link for $element"
	echo "ln -s $target $HOME/$link_name"
	ln -s $target $HOME/$link_name
}

while getopts ":c:?e:?a:?i?r:?" opt; do
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
			[ $UPDATE = 1 ] || [ $ADD = 1 ] || [ $REMOVE = 1 ] || [ $INSTALL = 1 ] &&
			{
				show_help
				exit 1
			}
			CREATE=1
			ENVIRONMENT=$OPTARG
			;;
		a)
			[ $REMOVE = 1 ] || [ $INSTALL = 1 ] || [ $CREATE = 1 ] || [ $UPDATE = 0 ] &&
			{
				show_help
				exit 1
			}
			ADD=1
			ARG=$OPTARG
			;;
		r)
			[ $ADD = 1 ] || [ $INSTALL = 1 ] || [ $CREATE = 1 ] || [ $UPDATE = 0 ] &&
			{
				show_help
				exit 1
			}
			REMOVE=1
			ARG=$OPTARG
			;;
		i)
			[ $REMOVE = 1 ] || [ $ADD = 1 ] || [ $CREATE = 1 ] || [ $UPDATE = 0 ] &&
			{
				show_help
				exit 1
			}
			INSTALL=1
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
	create $ENVIRONMENT
	exit 0
fi

cd $ENVIRONMENT

if [ $ADD = 1 ]; then
	add $ARG
elif [ $REMOVE = 1 ]; then
	remove $ARG
elif [ $INSTALL = 1 ]; then
	install_environment
else
	show_help
fi
