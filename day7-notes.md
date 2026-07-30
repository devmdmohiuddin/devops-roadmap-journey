# Day 7: SSH Key Generation and Remote Server Access

## Why key-based authentication is more secure than password authentication

Password authentication requires entering the server's login password every time you connect. If the password is weak, leaked, or guessed through a brute-force attack, an attacker may be able to access the server.

Key-based authentication is much more secure and is considered the industry best practice. When you run:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

SSH generates two keys:

* **Private key** (`id_ed25519`) – Keep this secret and never share it.
* **Public key** (`id_ed25519.pub`) – This can be safely copied to the remote server.

The public key is added to the server, and the private key stays on your local machine. During login, SSH verifies that your private key matches the public key stored on the server, allowing you to connect without entering the server password.

---

## What `known_hosts` and `authorized_keys` do

### `known_hosts`

The `known_hosts` file is located on the **client** machine:

```text
~/.ssh/known_hosts
```

It stores the public host keys of remote servers you have connected to before. This helps SSH verify the server's identity and protects against man-in-the-middle attacks.

### `authorized_keys`

The `authorized_keys` file is located on the **remote server**:

```text
~/.ssh/authorized_keys
```

It contains the public keys that are allowed to log in to that user account. If your public key is listed in this file, you can authenticate using your private key.

---

## SSH and SCP commands

### Connect to a remote server

```bash
ssh root@<SERVER_IP>
```

Or, if using a specific private key:

```bash
ssh -i ~/.ssh/id_ed25519 root@<SERVER_IP>
```

### Copy a file to a remote server

```bash
scp /path/to/local/file.txt root@<SERVER_IP>:/home/ubuntu/
```
