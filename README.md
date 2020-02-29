# ecflow-docker

A docker image for ecFlow python API with python 3.

## Build

### Prepare

ecflow-docker needs boost and ecflow source code. 
The Base dockerfile will download them during build stage.
If you don't want to download files every time, you can put them under ./dist/ecflow_code directory.

### Base

```bash
docker build --rm --tag nwpc-oper/ecflow-base -f docker/base/Dockerfile .
```

### Python

```bash
docker build --rm --tag nwpc-oper/ecflow-python -f docker/python/Dockerfile .
```

### Server

```bash
docker build --rm --tag nwpc-oper/ecflow-server -f docker/server/Dockerfile .
```

### ecflow_ui

```bash
docker build --rm --tag nwpc-oper/ecflow-ui -f docker/ui/Dockerfile .
```

## Run ecFlow Server

Use image `nwpc-oper/ecflow-server` to run ecFlow server.

```bash
docker run -d -p <some port>:3141 --name my-ecflow-server nwpc-oper/ecflow-server
```

## LICENSE

Copyright &copy; 2018-2020, Perilla Roc at nwpc-oper.

`ecflow-docker` is licensed under [MIT](LICENSE.md)