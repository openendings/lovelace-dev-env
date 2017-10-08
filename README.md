# lovelace-dev-env

## Prerequisites for building locally

You need access to:
- a copy of `judge`, in the working directory, and
- a copy of `train`, in the working directory.

You also need Docker, for some reason.

Then, run:
```
docker build -t lovelace-dev-env . --build-arg TRAIN_DIR=<train directory> --build-arg JUDGE_DIR=<judge directory>
```
