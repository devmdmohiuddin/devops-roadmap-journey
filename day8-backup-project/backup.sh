#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/devops-practice"
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.zip"

# Make sure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Check that the source directory actually exists before trying to back it up
if [ -d "$SOURCE_DIR" ]; then
    zip -r "$BACKUP_FILE" "$SOURCE_DIR"
    echo "[$(date)] Backup successful: $BACKUP_FILE"
else
    echo "[$(date)] ERROR: Source directory $SOURCE_DIR not found!"
    exit 1
fi