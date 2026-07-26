# Day 4 Notes: Linux Filesystem & Navigation

## Absolute Path vs Relative Path

A **relative path** starts from my current working directory. It does not begin with `/` and depends on where I am in the terminal. For example, if I am in my home directory (`~`), I can move to the `scripts` folder using:

```bash
cd devops-practice/scripts
```

An **absolute path** always starts from the root directory (`/`) or can be written from my home directory using `~`. It always points to the same location regardless of my current directory. For example:

```bash
cd ~/devops-practice/projects/sample-app
```

## Commands I Ran

```bash
mkdir -p devops-practice/configs
mkdir -p devops-practice/scripts
mkdir -p devops-practice/logs
mkdir -p devops-practice/projects/sample-app

cd devops-practice/scripts

touch hello.sh

cp hello.sh ../configs/

cd ../configs
mv hello.sh hello-backup.sh

cd ~/devops-practice/projects/sample-app

cd ..
cd ..

ls -R
```

## What I Practiced

* Creating nested directories with `mkdir -p`
* Navigating using both relative and absolute paths
* Creating files with `touch`
* Copying files with `cp`
* Renaming files with `mv`
* Viewing the directory structure recursively with `ls -R`
