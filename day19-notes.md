## 1. What does each Dockerfile instruction do?

### `FROM`

`FROM` specifies the base image for my Docker image.

For example:

```dockerfile
FROM python:3.12-slim
```

This gives my Flask application a lightweight Python environment to run in.

### `WORKDIR`

`WORKDIR` sets the working directory inside the Docker image.

```dockerfile
WORKDIR /app
```

After this, commands and files are handled relative to `/app`.

### `COPY`

`COPY` copies files from my project into the Docker image.

For example:

```dockerfile
COPY requirements.txt .
COPY app.py .
```

This puts my dependency file and Flask application inside the image.

### `RUN`

`RUN` executes a command while the Docker image is being built.

For example:

```dockerfile
RUN pip install --no-cache-dir -r requirements.txt
```

This installs the Python dependencies into the image.

`RUN` happens at **build time**.

### `EXPOSE`

`EXPOSE` tells Docker which port the application is expected to use.

For my Flask application:

```dockerfile
EXPOSE 5000
```

However, `EXPOSE` does not actually make the port reachable from my host machine. It is mainly documentation and image metadata.

To publish the port, I need to use `-p` when running the container:

```bash
docker run -p 5000:5000 flask-app
```

### `CMD`

`CMD` specifies the default command that should run when a container starts.

For example:

```dockerfile
CMD ["python", "app.py"]
```

This starts my Flask application when the container runs.

`CMD` happens at **container run time**, not during the image build.

---

## 2. What is the difference between `RUN` and `CMD`?

The main difference is **when they run**.

### `RUN` — Build Time

`RUN` executes when I build the Docker image.

```dockerfile
RUN pip install -r requirements.txt
```

For example:

```bash
docker build -t flask-app .
```

During this build, Docker executes the `RUN` command and saves the result in the image.

### `CMD` — Run Time

`CMD` specifies what Docker should run when I start a container.

```dockerfile
CMD ["python", "app.py"]
```

For example:

```bash
docker run flask-app
```

When the container starts, the `CMD` launches my Flask application.

A simple way to remember it:

> **RUN builds the image, CMD runs the application inside the container.**

---

## 3. Why doesn't `EXPOSE` alone make a port reachable?

`EXPOSE` does not create a connection between my computer and the Docker container.

For example:

```dockerfile
EXPOSE 5000
```

This tells Docker that my application uses port `5000`, but it does not publish that port to my host machine.

I need to explicitly publish the port when starting the container:

```bash
docker run -p 5000:5000 flask-app
```

The mapping means:

```text
My computer                    Docker container
localhost:5000  ------------>  port 5000
```

So I understand it as:

> `EXPOSE` tells Docker about the port, while `-p` actually publishes the port so I can access the application from my computer.

Also, my Flask application needs to listen on `0.0.0.0` inside the container so that it can accept connections from outside the container.

---

## 4. What did I observe in Step 6, and why does instruction ordering affect caching?

In Step 6, I observed that Docker reused cached steps when I rebuilt the image.

The Dockerfile was organized so that `requirements.txt` was copied and installed before the application code:

```dockerfile
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
```

When I changed only `app.py`, Docker was able to reuse the cached dependency installation step because `requirements.txt` had not changed.

This saved time because Docker did not need to install the Python packages again.

The instruction ordering makes this possible because Docker builds the image step by step. When an earlier step can be reused from the cache, Docker can continue using the cached result until it reaches a step affected by a change.

For example:

```text
COPY requirements.txt .
        ↓
RUN pip install ...
        ↓
COPY app.py .
```

If only `app.py` changes:

```text
COPY requirements.txt .     → CACHE USED
RUN pip install ...         → CACHE USED
COPY app.py .               → REBUILT
```

This is why it is useful to put files that change less frequently, such as `requirements.txt`, before files that change more frequently, such as `app.py`.

---

## Conclusion

Today I learned how Dockerfile instructions work and how Docker uses layers and caching when building images.

The most important things I learned are:

* `RUN` executes during the **image build**.
* `CMD` executes when the **container starts**.
* `EXPOSE` documents the container port but does not publish it.
* `-p` is used to publish a container port to the host.
* Docker can reuse cached build steps.
* Putting `requirements.txt` and dependency installation before `app.py` makes rebuilds faster when only the application code changes.

This Dockerized Flask application will be kept as the same project for the next stages of my DevOps journey.
