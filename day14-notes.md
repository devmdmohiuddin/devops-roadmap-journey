## 1. What is a branch?

A Git branch is **not a copy** of the project. A branch is simply a **pointer** (or reference) to the latest commit.

For example, when I create a `feature` branch from `main`, Git does not duplicate all the files. Instead, the new branch points to the same latest commit as `main`. As I make new commits on the `feature` branch, only the `feature` pointer moves forward while `main` stays where it is.

---

## 2. Fast-Forward Merge vs. Three-Way Merge

### Fast-Forward Merge

A fast-forward merge happens when I create a feature branch from `main`, complete my work, and then merge it back **without any new commits being added to `main`**.

Since `main` has not changed, Git simply moves the `main` pointer forward to the latest commit on the feature branch. No merge commit is needed.

### Three-Way Merge

A three-way merge happens when both branches have new commits.

For example, I create a `feature` branch from `main`, but while I am working, another developer adds commits to `main` and merges their work first. Now my feature branch and `main` have different histories.

When I merge my branch, Git cannot simply move the pointer forward. Instead, it combines both histories by creating a **merge commit** with two parent commits.

---

## 3. Merge Conflict in `hello.sh`

When I merged my branch, Git found that both branches had changed the same lines in `hello.sh`. Since Git could not decide which version was correct, it created a merge conflict.

Inside the file, I saw conflict markers like this:

```text
<<<<<<< HEAD
content from main branch
=======
content from feature branch
>>>>>>> feature
```

To resolve the conflict, I manually edited the file and kept the changes I wanted. After removing the conflict markers, I saved the file, staged it with `git add hello.sh`, and completed the merge by creating the merge commit.

---

## 4. GitHub Flow (9 Steps)

1. Start with the latest version of the `main` branch.
2. Create a new branch for your feature or bug fix.
3. Make your changes in that branch.
4. Commit your work with clear commit messages.
5. Push the branch to GitHub.
6. Open a Pull Request (PR).
7. Review the changes and discuss them if needed.
8. Merge the Pull Request into `main`.
9. Delete the feature branch after it has been merged.
