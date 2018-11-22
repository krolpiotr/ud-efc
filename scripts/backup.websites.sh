#!/bin/bash

# backup.websites.sh
#
# version 1.0.2
#
# Backup of websites on your Ubuntu Server 16.04
# author : Piotr Krol, simonphoenix.px@gmail.com
# website: simon-phoenix.se
# ------------------------------------------------------------------------
# Configuration
# directory for websites
WEBDIR="/home/phoenix/Server"
BACKUPSDIR="/home/phoenix/Backups/home/Server"
# ------------------------------------------------------------------------
# name: backup_website() 
# desc: Backup website
# args: project name,mysql database,mysql host,mysql user,mysql password
# return: 0
# ------------------------------------------------------------------------
backup_website() {

    PROJECT=$1
    DATABASE=$2
    DBHOST=$3
    DBUSERNAME=$4
    DBPASSWORD=$5


    if [ ! -d "$WEBDIR" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your websites doesn't exist."
       echo "           Check configuration."
       return 0
    fi

    if [ ! -d "$BACKUPSDIR" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your backups doesn't exist."
       echo "           Check configuration."
       return 0
    fi

    if [ -z "$DATABASE" ]
      then
        echo "           Backup of $PROJECT"
    else
        echo "           Backup of $PROJECT and database $DATABASE"
    fi
