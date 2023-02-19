# Mongodb replica set using docker

- Add the following entry in your `/etc/hosts` file

```
127.0.0.1       host.docker.internal
```

- `docker compose up`

- Connect to mongo replica set url

```
mongosh "mongodb://localhost:27021,localhost:27022,localhost:27023/?replicaSet=rs1"
```
