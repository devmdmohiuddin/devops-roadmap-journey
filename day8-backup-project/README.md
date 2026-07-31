# Day 8 - Automated Backup Script with Cron Scheduling

## Overview

This project automates a manual backup task using a Bash script and Cron.

Instead of running multiple commands every time a backup is needed, this script performs the entire process with a single command. This saves time, reduces repetitive work, and minimizes the chance of human error.

Once the script was verified manually, it was scheduled with Cron to run automatically at a specific time.

---

## What the Script Does

The backup script automates the following tasks:

1. Checks whether the source file or directory exists.
2. Creates a backup with a unique timestamp.
3. Stores the backup in the backup directory.
4. Records the result in a log file.
5. Reports whether the backup completed successfully or failed.

This replaces a manual backup process with a reliable automated workflow.

---

## Why Each Part Exists

### Timestamping

Every backup includes a timestamp in its filename.

Example:

```
backup_2026-08-01_02-00-00.tar.gz
```

This ensures:

- Every backup has a unique name.
- Older backups are never overwritten.
- It is easy to identify when each backup was created.

---

### Existence Check

Before starting the backup, the script verifies that the source file or directory exists.

If the source is missing:

- The backup is not created.
- The script exits safely.
- An error is written to the log.

This prevents invalid or empty backups.

---

### Logging

Each execution is written to a log file.

The log records:

- Date and time
- Success or failure
- Error messages (if any)

Logging makes it much easier to monitor scheduled jobs and troubleshoot problems.

---

## Cron Schedule

Cron is used to automate the backup without requiring manual execution.

Cron schedule:

```cron
0 2 * * * /home/user/day8-backup-project/backup.sh
```

### Why this schedule?

The backup runs every day at **2:00 AM**.

This is a common time for scheduled maintenance because system usage is generally lower, reducing the impact on users while ensuring backups are created consistently.

---

## Manual Testing

Before trusting the Cron schedule, I tested the script manually several times.

The manual tests verified that:

- The backup was created successfully.
- Timestamped backup names were generated correctly.
- Missing files or directories were handled properly.
- Success and failure messages were written to the log.
- The script completed without errors.

After confirming that everything worked as expected, I configured the Cron job to run the script automatically.

---

## Skills Demonstrated

This project demonstrates several core DevOps skills:

- Bash scripting
- Process automation
- Cron scheduling
- File and directory validation
- Logging
- Error handling
- Linux command-line usage

---

## Why This Project Matters

Automating repetitive tasks is one of the most common responsibilities of a DevOps engineer.

This project demonstrates how a manual process can be converted into a reliable automated workflow using Bash scripting and Cron, improving efficiency, consistency, and reliability.