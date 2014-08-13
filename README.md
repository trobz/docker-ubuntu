## Description

This docker image is use as a base for all ubuntu's images.

## Features

### Default user creation

A user is created based on these envionment variables:

```
ENV USERNAME docker
ENV PASSWORD docker
ENV USER_UID 1000
ENV USER_GID 1000
ENV USER_HOME /home/docker
```

The image is also provide basic prompt features (color, git branch info, etc...) and a profile skeleton with some basic
init profile scripts (`.bashrc, .screenrc, ...`).

### Container pre-execution scripts

Very often, the customization of a container take place at the first run of it.
To simplify this initialization, this image provide a mecanism to handle it:

- image are all setup with `CMD /usr/local/docker/main.sh`, it's required to keep this mecanism up.
- `main.sh` will decide to run init script if it's the first container run or not.
- `setup.sh` will run all scripts located in `/usr/local/docker/start/init` folder, by convention,
each init script start with a number (the running level)

When this image is reused and you need a pre-execution script for your container,
you can simply `ADD` a new init script in the `/usr/local/docker/start/init`.

Some bash help functions are available for your init scripts:

```bash
# logging: different level, with colorized log level
info <text>
debug <text>
warn <text>
error <text>
# exit the script with code 1
die

# file manipulation
replace_env <file>  # replace all environment variable in a text file, env have to follow this syntax: {ENV_NAME}

# some pre-defined environment variables
IS_ONLINE   # 0 if WAN network is available (based on return code from ping 8.8.8.8)
DIR         # absolute location of `main.sh` script

```
## Build

`build.sh` script is used to build this image on different version of ubuntu server with the same Dockerfile.
It use `Dockerfile.tmpl` to generate one specific to the ubuntu source version, then run the build.



