# 1. Custom Docker Networks

A user-defined Docker network allows containers to communicate
with each other using container names.

For example, if a container is named `mongo`, another container
on the same custom network can use `mongo` as the hostname.

This is better than using IP addresses because container IP
addresses can change.

## 2. Named Volumes

A named volume is Docker-managed persistent storage.

Example:

docker volume create mongo-data

A volume can be attached to a container:

```bash
docker run -v mongo-data:/data/db mongo
```

The volume survives even when the container is deleted.

## 3. Named Volume vs Bind Mount

Named volume:

```bash
docker run -v mongo-data:/data/db mongo
```

Docker manages the storage location.

Bind mount:

```bash
docker run -v /home/user/data:/data/db mongo
```

I choose the exact host directory.

Named volumes are useful for persistent application data.
Bind mounts are useful when I need direct access to host files,
especially during development.

## 4. What I Observed

I created a MongoDB container with the `mongo-data` volume.

I created a database and document through Mongo Express.

Then I stopped and removed the MongoDB container.

The `mongo-data` volume remained.

I recreated the MongoDB container using the same volume.

After refreshing Mongo Express, the database and document
were still present.

This proved that the volume stores the persistent data
independently of the container lifecycle.

## 5. Commands

```bash
docker network create mongo-network

docker network ls

docker volume create mongo-data

docker volume ls

docker run -d \
  --name mongo \
  --network mongo-network \
  -v mongo-data:/data/db \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password123 \
  mongo

docker run -d \
  --name mongo-express \
  --network mongo-network \
  -e ME_CONFIG_MONGODB_SERVER=mongo \
  -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
  -e ME_CONFIG_MONGODB_ADMINPASSWORD=password123 \
  -p 8081:8081 \
  mongo-express

docker logs mongo-express

docker network inspect mongo-network

docker volume inspect mongo-data
```