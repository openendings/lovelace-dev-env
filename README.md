# lovelace-dev-env

## Running the image

```
$ docker run -dt \
  --mount type=bind,src=<LOVELACE SRC DIRECTORY>,dst=/home/lovelace/lovelace-src \
  <IMAGE NAME>
```

This will initialise a Lovelace-friendly Docker container in the background.
You can get its name with `docker ps`, and bring it down with `docker kill <CONTAINER NAME>`.

You can run commands as the `lovelace` user with `docker exec -u lovelace -it <IMAGE NAME> <CMD>`.
Setting "`bash`" as a command gives you a shell.

###

**Q:** I get the error `docker: No such file or directory`.

**A:** Oh, right, I forgot to tell you to install docker. Do that, please.

## Prerequisites for building locally

You need access to:
- a copy of `judge`, in the working directory, and
- a copy of `train`, in the working directory.

Then, run:
```
docker build -t lovelace-dev-env . --build-arg TRAIN_DIR=<train directory> --build-arg JUDGE_DIR=<judge directory>
```
