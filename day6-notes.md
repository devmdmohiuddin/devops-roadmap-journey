# Day 6 Notes

## Difference Between SIGTERM and SIGKILL

`SIGTERM` (signal **15**) is the default signal sent by the `kill` command.

- It asks the process to terminate gracefully.
- The process gets a chance to finish its current work, save data, close files, and clean up before exiting.
- The process can choose to handle or ignore this signal.

`SIGKILL` (signal **9**) forcefully stops a process.

- It immediately terminates the process.
- The process cannot ignore or catch this signal.
- Since it stops instantly, it does not get a chance to clean up or save its state.

## Why `systemctl` with `Restart=always` is Better Than Running a Process with `&`

Running a process with `&` only starts it in the background. If the process crashes, is killed, or the server reboots, it will not automatically start again.

Using `systemctl` with `Restart=always` is better for a real production service because:

- The service automatically restarts if it crashes.
- It starts automatically after a server reboot.
- It is managed by `systemd`, making it easier to monitor, start, stop, and check logs.
- There is no need to manually restart the process every time something goes wrong.

## Commands I Used

```bash
sleep 500 &
```

Find the process ID (PID):

```bash
ps aux | grep sleep
```

Kill the process:

```bash
kill <PID>
```

Example:

```bash
kill 12345
```

If the process does not stop, force kill it:

```bash
kill -9 12345
```

## PID I Found and Killed

**PID:** `12345`

> Replace `12345` with the actual PID you found on your system.