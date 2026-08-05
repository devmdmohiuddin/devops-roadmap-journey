## Working Directory vs Staging Area vs Repository

### Working Directory

The **working directory** is where We create, edit, and delete files. Any changes We make are only in my local files until We decide to track them with Git.

### Staging Area

The **staging area** is where We prepare changes before creating a commit. When We run `git add`, Git takes a snapshot of the selected changes and marks them as ready to be committed.

### Repository

The **repository** is where Git permanently stores the commit history. Every time We run `git commit`, Git saves a new snapshot of the project, allowing me to view or restore previous versions whenever needed.

---

## Why Git Stores Full Snapshots Instead of Diffs

Git stores **full snapshots** of the project instead of only storing the differences between files. This makes it very fast to restore any previous commit because Git can directly access the snapshot without rebuilding it from a long chain of changes.

Although it sounds like storing full snapshots would use more space, Git is actually very efficient. If a file has not changed since the previous commit, Git simply reuses the existing file data instead of storing another copy. This saves storage while keeping commits fast and reliable.

