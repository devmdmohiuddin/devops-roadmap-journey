# Day 9 – Installed and Verified Nginx via apt Package Manager

## 1. Difference Between `apt update` and `apt upgrade`

A common beginner confusion is thinking that `apt update` updates the installed software. It does not.

### `apt update`

`apt update` refreshes the package information stored on my system.

It contacts the configured package repositories and downloads the latest package lists.

It answers questions like:

- What packages are available?
- What versions are available?
- Are there newer versions?

Example:

```bash
sudo apt update
```

Important point:

`apt update` does **not install or upgrade anything**.

It only updates the package database.

Think of it like refreshing a shopping catalog before buying something.

---

### `apt upgrade`

`apt upgrade` actually installs newer versions of packages that are already installed on the system.

Example:

```bash
sudo apt upgrade
```

It:

- Downloads newer package versions.
- Replaces old versions.
- Updates installed libraries and applications.

Think of it like using the updated catalog from `apt update` to actually purchase and install the newer items.

---

### Simple Comparison

| Command | Purpose | Changes installed software? |
|---------|---------|-----------------------------|
| `apt update` | Updates package lists | No |
| `apt upgrade` | Installs available updates | Yes |

The normal workflow is:

```bash
sudo apt update
sudo apt upgrade
```

First, get the latest information. Then apply the upgrades.

---

# 2. Why Minimal Base Images Matter for Security

In DevOps, we should keep server images and container images as small as possible.

A minimal base image contains only the software required to run the application.

For example:

A web application container does not need:

- Text editors
- Debugging tools
- Extra networking utilities
- Unused libraries
- Additional services

---

## Security Benefits

Every installed package increases the possible attack surface.

More software means:

- More code that can contain vulnerabilities.
- More packages to monitor and update.
- More configuration files to manage.
- More difficulty during security audits.

A smaller image is easier to understand, scan, and maintain.

---

## Real-World Consequence of a Bloated Server

An unnecessarily large server image can create several problems:

### 1. More Security Vulnerabilities

If a server contains hundreds of unnecessary packages, one vulnerable package can become an entry point for attackers.

### 2. Harder Auditing

Security teams must check more software, dependencies, and configurations.

### 3. Slower Deployment

Large images:

- Take longer to download.
- Take longer to start.
- Consume more storage and bandwidth.

For example, a container image with many unnecessary libraries may take much longer to deploy across Kubernetes nodes compared to a minimal image containing only the application and required dependencies.

---

# 3. Installing and Verifying Nginx

## Step 1: Update Package Information

```bash
sudo apt update
```

This refreshed the package repository information.

---

## Step 2: Install Nginx

```bash
sudo apt install nginx
```

This installed the Nginx web server.

---

## Step 3: Check Nginx Status

```bash
sudo systemctl status nginx
```

Expected result:

```
Active: active (running)
```

This confirms that the Nginx service is running.

---

## Step 4: Test Nginx Using curl

I verified that Nginx was serving a webpage using:

```bash
curl localhost
```

Terminal output:

```bash
PASTE YOUR ACTUAL CURL OUTPUT HERE
```

Example:

```html
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
</head>
<body>
<h1>Welcome to nginx!</h1>
</body>
</html>
```

This confirmed that Nginx successfully received an HTTP request and returned a webpage.

---

# Summary

Today I learned:

- `apt update` refreshes package information but does not install updates.
- `apt upgrade` installs newer versions of already installed packages.
- Minimal images improve security by reducing unnecessary software and vulnerabilities.
- Nginx can be installed using the apt package manager and verified using `curl`.

The complete flow was:

```
apt update
      ↓
apt install nginx
      ↓
nginx service starts
      ↓
curl localhost
      ↓
Nginx returns webpage
```