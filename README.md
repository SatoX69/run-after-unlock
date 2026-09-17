# Run When Unlocked

A Magisk module that runs executable shell scripts after the phone is unlocked.

## Usage

Place your `.sh` files inside:

/data/local/run-when-unlocked/

Make them executable:

```sh
chmod +x /data/local/run-when-unlocked/example.sh
```

The scripts will run automatically after the first unlock.

Notes:

Only executable .sh files are run.

The module waits until Android unlocks the device.
