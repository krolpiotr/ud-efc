#!/bin/bash

# general.backup.sh
#
# version 1.0.2
#
# General Backup of Ubuntu Server 18.10
# author: Piotr Krol, simonphoenix.px@gmail.com

# ------------------------------------------------------------------------
# Configuration
# directory for websites
BACKUPSDIR="/home/phoenix/Backups"
GENERALBACKUPSDIR="/home/phoenix/General"
# ------------------------------------------------------------------------
# name: general_backup() 
# desc: Backup of Backups to one file
# return: 0
# ------------------------------------------------------------------------
general_backup() {

    if [ ! -d "$BACKUPSDIR" ]; then
       # Control will enter here if "$BACKUPSDIR" doesn't exist.
       echo "           Directory of your backups doesn't exist."
       echo "           Check configuration."
       return 0
    fi

    if [ -d "$GENERALBACKUPSDIR" ]; then
      echo '           General backup destination exist....'
    else
      echo '           General backup destination not exist....'
      echo '           Creating "General" here....'
      mkdir -p "$GENERALBACKUPSDIR"
      sudo chmod 755 "$GENERALBACKUPSDIR"
      sudo chown phoenix:phoenix "$GENERALBACKUPSDIR"
    fi
    
    PROJECT="Backups"
    BACKUPFILE=$PROJECT-`date +%Y-%m-%d`.tar.gz

    echo "           General Backup directory...."

    cd "$GENERALBACKUPSDIR"

    if [ -e "$GENERALBACKUPSDIR/"$BACKUPFILE ]
      then
      # we did backup today
      echo "           Backup of $BACKUPFILE - done"
    else
      # we will make a backup
      echo "           Backup of $PROJECT - not done... creating backup..."
      cd "/home/phoenix"
      tar czfP "$GENERALBACKUPSDIR/$BACKUPFILE" "$PROJECT"
      sudo chmod 755 "$GENERALBACKUPSDIR/$BACKUPFILE"
      sudo chown phoenix:phoenix "$GENERALBACKUPSDIR/$BACKUPFILE"
    fi
}
# ------------------------------------------------------------------------
# name: clean_backups() 
# desc: Backups older than 3 days are deleted
# return: 0
# ------------------------------------------------------------------------
clean_backups() {
    dird="$GENERALBACKUPSDIR/"
    days=7
    echo -n "           removing files in $BACKUPSDIR that are older than $days days: "
    find "$dird" -mtime +$days -type f -exec echo {} \; -exec rm {} \; | wc -l
}
# ------------------------------------------------------------------------

echo '# -----------------------------------------------------------------------#'
echo '#          General Buckup                                                #'
echo '# -----------------------------------------------------------------------#'
