# Backup & Restore of named volumes defined within docker-compose

Optionally list your docker volume name and get a volumn name or use the prefix of the docker compose file for backing up all volumes in this file
```bash
$ docker volume ls
DRIVER    VOLUME NAME
local     my_compose_prefix_my-volume-name1
local     my_compose_prefix_my-volume-name2
local     my_compose_prefix_my-volume-name3
```

## Backup
```bash
# usage: backup_docker_volume.sh <compose_name> [<optional volume name>]
$ backup_docker_volume.sh my_compose_prefix my-volume-name1
#--> stores the volume data in the file "<script_dir>/my_compose_prefix_my-volume-name1_20231111T434242+0100.tar.gz"

$ backup_docker_volume.sh my_compose_prefix
#--> creates three files:
#    "<script_dir>/my_compose_prefix_my-volume-name1_20231111T434242+0100.tar.gz"
#    "<script_dir>/my_compose_prefix_my-volume-name2_20231111T434242+0100.tar.gz"
#    "<script_dir>/my_compose_prefix_my-volume-name3_20231111T434242+0100.tar.gz"
```

## Restore
```bash
# restore_docker_volume.sh <path/to/compressed_tar_file.tar.gz> <fully_qualified_volume_name>
restore_docker_volume.sh /root/backups/backup_data/my_compose_prefix_my-volume-name1_20231111T434242+0100.tar.gz my_compose_prefix_my-volume-name1
```
