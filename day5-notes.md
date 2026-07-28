# Day 5 Notes: Permissions and Shell Commands

## File Permissions

### 644
- **Owner:** Read and write (`rw-`)
- **Group:** Read only (`r--`)
- **Others:** Read only (`r--`)

**When to use:**
Use `644` for regular files such as configuration files, documentation, and source code. The owner can modify the file, while everyone else can only read it.

---

### 600
- **Owner:** Read and write (`rw-`)
- **Group:** No permissions (`---`)
- **Others:** No permissions (`---`)

**When to use:**
Use `600` for sensitive files such as SSH private keys, password files, or any file that should only be accessible by the owner.

---

### 755
- **Owner:** Read, write, and execute (`rwx`)
- **Group:** Read and execute (`r-x`)
- **Others:** Read and execute (`r-x`)

**When to use:**
Use `755` for executable scripts, programs, and directories. The owner can modify the file, while everyone else can read and execute it.

---

## Difference Between `>` and `>>`

### `>`
The `>` operator redirects output to a file and **overwrites** the file if it already exists.

Example:

```bash
echo "Deployment started" > deploy.log
```

If `deploy.log` already contains data, it will be replaced with:

```
Deployment started
```

### `>>`
The `>>` operator redirects output to a file and **appends** the new output to the end of the file without deleting the existing contents.

Example:

```bash
echo "Step 1 complete" >> deploy.log
```

If `deploy.log` contains:

```
Deployment started
```

After running the command, it becomes:

```
Deployment started
Step 1 complete
```

---

## `grep` with a Pipe

Example command:

```bash
cat app.log | grep "ERROR"
```

### What it does

1. `cat app.log` prints the contents of `app.log`.
2. The pipe (`|`) sends that output to the next command.
3. `grep "ERROR"` searches the input and displays only the lines containing the word `ERROR`.

Example output:

```
ERROR: Database connection failed
ERROR: Authentication failed
```