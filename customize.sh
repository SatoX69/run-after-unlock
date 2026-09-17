SKIPUNZIP=0

ui_print " "
ui_print "Run When Unlocked"
ui_print " "
ui_print "Choose unlock wait mode:"
ui_print " "
ui_print "VOL UP   = Strict (20s wait, 6 attempts [DEFAULT])"
ui_print "VOL DOWN = Infinite wait"
ui_print " "
ui_print "Waiting 10 seconds..."

MODE="strict"

timeout=10
while [ $timeout -gt 0 ]; do
    EVENT=$(getevent -qlc 1 2>/dev/null)

    echo "$EVENT" | grep -q "KEY_VOLUMEUP" && {
        MODE="strict"
        break
    }

    echo "$EVENT" | grep -q "KEY_VOLUMEDOWN" && {
        MODE="infinite"
        break
    }

    sleep 1
    timeout=$((timeout-1))
done

mkdir -p "$MODPATH/config"

echo "$MODE" > "$MODPATH/config/unlock_mode"

if [ "$MODE" = "strict" ]; then
    ui_print "- Selected: Strict mode (6 attempts)"
else
    ui_print "- Selected: Infinite mode"
fi
