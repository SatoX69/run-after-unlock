#!/system/bin/sh

MODDIR=${0%/*}

TARGET="/data/local/run-when-unlocked"
CONFIG="$MODDIR/config/unlock_mode"
LOGFILE="/data/local/run-when-unlocked.log"

(
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 5
    done

    MODE="strict"

    if [ -f "$CONFIG" ]; then
        MODE="$(cat "$CONFIG")"
    fi

    if [ "$MODE" = "strict" ]; then

        ATTEMPTS=0

        while [ "$(getprop sys.user.0.ce_available)" != "true" ]; do
            sleep 20

            ATTEMPTS=$((ATTEMPTS + 1))

            if [ "$ATTEMPTS" -ge 6 ]; then
		    # No need to log as of now
                exit 0
            fi
        done

    else

        while [ "$(getprop sys.user.0.ce_available)" != "true" ]; do
            sleep 20
        done

    fi

    sleep 30

    mkdir -p "$TARGET"
    chmod 755 "$TARGET"

    for SCRIPT in "$TARGET"/*.sh; do
        [ -f "$SCRIPT" ] || continue
        [ -x "$SCRIPT" ] || continue

        "$SCRIPT" >/dev/null 2>&1 &
    done

) &

exit 0
