#!/bin/bash
#
# Restore backup performed with "backup_docker_volume.sh"
#
# bash restore_docker_volume.sh <path/to/compressed_tar_file.tar.gz> <fully_qualified_volume_name>
#
# split dir and basename of archive file
ARCHIVE_DIR=$( dirname -- "$1" )
FILE_NAME=$( basename -- "$1" )
# find relative dir of tar file
RELATIVE_DIR=$( realpath --relative-to="$(pwd)" "$ARCHIVE_DIR" )

# executing restore
echo "Restoring $1 to volume $2"
docker run --rm --volume $2:/volumedata --volume $(pwd):/bdir ubuntu tar xzf /bdir/$RELATIVE_DIR/$FILE_NAME -C /volumedata --strip 1
