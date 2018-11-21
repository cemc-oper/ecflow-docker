# ecflow-docker

A docker image for ecFlow python API with python 3.

## Build

### Prepare

ecflow-docker needs boost and ecflow source code. 
The Base dockerfile will download them during build stage.
If you don't want to download files every time, you can put them under ./dist/ecflow_code directory.

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