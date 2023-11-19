#!/bin/bash
#
# Perform backup of one or multiple volumes linked to a docker compose.
# - Specifying only the docker compose name as first argument perform backup of all linked volumes.
# - Specify compose name and volume name as first and second argument backups only this volume.
# 
# backup_docker_volume.sh <compose_name> [<optional_compose_volume_name>]
#
# script dir
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# find relative dir 
RELATIVE_DIR=$( realpath --relative-to="$(pwd)" "$SCRIPT_DIR" )
# define docker compose name from input
COMPOSE_FILENAME=$1
# define volume_name
VOLUME_NAME=$2

function vol_backup {
	echo "Executing backup for volumne $1"
	# define name of backup file
	BACKUP_PATH="$2/$1_`TZ=":Europe/Berlin" date +%Y%m%d"T"%H%M%S%z`.tar.gz"
	# executing backup
	docker run --rm --volume $1:/volumedata --volume $(pwd):/bdir ubuntu tar czf /bdir/$BACKUP_PATH /volumedata
	
	if [ -f "$BACKUP_PATH" ]; then
		echo "Backup of $1: $(pwd)/$BACKUP_PATH"
	else
		echo "Backup of $1 was NOT SUCCESSFUL!"
	fi
}

if [ -z "$1" ]; then
	echo "No valid options provided. Usage:"
	echo "$0 <compose_name> [<volume_name>]"
elif [ -z "$2" ]; then
	for VOL in $(docker volume ls -q | grep $1)
	do
		vol_backup $VOL $RELATIVE_DIR
	done
else
	vol_backup "$1_$2" $RELATIVE_DIR
fi
