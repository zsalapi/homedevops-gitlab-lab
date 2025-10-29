#!/bin/bash
#You can backup Gitlab data with this script
DATE=$(date +%Y-%m-%d)
DEST="/backup/$DATE"
mkdir -p "$DEST"

rsync -a ./gitlab/data/ "$DEST/gitlab_data/"
rsync -a ./app/ "$DEST/app/"

echo "Backup completed at $(date)" >> ./backup/backup.log
