# ecflow-docker

A docker image for ecFlow python API with python 3.

## Build

### Base

```bash
docker build --rm --tag nwpc/ecflow:base -f docker/base/Dockerfile .
```

### Python

```bash
docker build --rm --tag nwpc/ecflow:python -f docker/python/Dockerfile .
```

### Server

```bash
docker build --rm --tag nwpc/ecflow:server -f docker/server/Dockerfile .
```

## Run ecFlow Server

Use image `nwpc/ecflow:server` to run ecFlow server.

```bash
docker run -d -p <some port>:3141 --name my-ecflow-server nwpc/ecflow:server
```