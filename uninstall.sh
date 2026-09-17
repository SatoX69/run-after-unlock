#!/system/bin/sh

SOURCE="/data/local/run-when-unlocked"
DEST="/sdcard/RUNAFTERUNLOCK"

if [ -d "$SOURCE" ]; then

    mkdir -p "$DEST"

    cp -a "$SOURCE"/. "$DEST"/ 2>/dev/null

    rm -rf "$SOURCE"

fi

exit 0
