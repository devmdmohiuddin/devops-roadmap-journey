## Docker Architecture

Docker has four core pieces that work together:

### 1. Docker Client

The Docker client is the command we use in the terminal.

For example:

```bash
docker run hello-world
```

The client sends our Docker commands to the Docker daemon.

### 2. Docker Daemon

The Docker daemon runs in the background and handles Docker operations.

When we type a Docker command in the terminal, the Docker client communicates with the daemon. The daemon then takes care of tasks such as downloading images, creating containers, starting containers, and managing them.

### 3. Docker Images

A Docker image is like a blueprint or template for a container.

It contains the files, dependencies, configuration, and instructions needed to run an application.

For example, the Nginx image contains what is needed to run an Nginx web server.

### 4. Docker Containers

A container is a running instance of an image.

The image is the blueprint, while the container is the actual running environment created from that blueprint.

The relationship can be summarized like this:

```text
Docker Client
     |
     v
Docker Daemon
     |
     +----> Docker Image
     |          |
     |          v
     +----> Docker Container
```

In simple words:

**Client → tells Docker what to do → Daemon → uses an Image → to create/run a Container.**

---

## Why Docker Image Layers Are Useful

Docker images are built from multiple layers. Each change in an image can create another layer.

These layers can be reused instead of being copied again for every container.

For example, if multiple containers use the same Nginx image, Docker does not need to store a completely separate copy of the image for every container. The containers can share the same underlying image layers.

This saves disk space.

Layers also make Docker builds faster. When we rebuild an image, Docker can reuse layers that have not changed instead of rebuilding everything from the beginning.

So image layers provide two important benefits:

* **Faster builds** because unchanged layers can be reused.
* **Less disk space** because shared layers do not need to be duplicated.

---

## Nginx: apt vs Docker

Earlier, on Day 9, I installed Nginx using `apt`.

With the traditional `apt` method, I had to install Nginx directly into the operating system. The package manager downloads and installs the required files on the machine, and Nginx becomes part of that system.

Today, I installed and ran Nginx using Docker.

With Docker, I can use an existing Nginx image and create a container from it. I do not need to install Nginx directly into my operating system.

### My Comparison

For me, **Docker felt faster and cleaner**.

The main reason is **reusable images**. Once an image is available, I can use the same image to create containers without going through the traditional installation process again.

The Docker approach also keeps the application environment separated from the host operating system. This makes it easier to start, stop, remove, and recreate Nginx without changing the system installation.

### Simple Comparison

| Method | How it works                                    | My experience                        |
| ------ | ----------------------------------------------- | ------------------------------------ |
| `apt`  | Installs Nginx directly on the operating system | More traditional system installation |
| Docker | Runs Nginx from a reusable Docker image         | Faster and cleaner                   |

Overall, Docker feels more convenient because the image can be reused and the application runs inside a container instead of being installed directly on my system.

---

## Key Takeaways

* The **Docker Client** is where I enter Docker commands.
* The **Docker Daemon** runs in the background and handles Docker operations.
* A **Docker Image** is a blueprint for an application environment.
* A **Docker Container** is a runnable instance of an image.
* **Image layers** can be shared and reused, which saves disk space.
* Reusing layers also makes Docker image builds faster.
* Compared with installing Nginx using `apt`, Docker felt **faster and cleaner** because I could use a reusable Nginx image and run it in a container.
