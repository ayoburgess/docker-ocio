# docker-ocio
docker-ocio defines a [Docker](https://www.docker.com) image that contains [OpenColorIO](http://www.http://opencolorio.org/) command line utilities (ociocheck and ociobakelut) and python bindings (PyOpenColorIO).
# Installation
```sh
$ docker pull ayoburgess/ocio
```
# Usage
Using python bindings to generate an OCIO config
```sh
$ git clone https://github.com/imageworks/OpenColorIO-Configs.git
$ cd OpenColorIO-Configs/nuke-default/
```
Now let's mount the current working directory to a docker container
```sh
$ docker run --rm -it -v ${PWD}:/mnt/ocio-config ayoburgess/ocio /bin/bash
```
Now we're inside of a Docker container with access to the OCIO python bindings (PyOpenColorIO) which we can use to generate a new OCIO config.
```sh
$ cd /mnt/ocio-config/
$ python make.py 
OCIO 1.1.0
Wrote config.ocio
$ exit
```
We've now exited the Docker container and have a newly created config.ocio in the current working directory. Now let's verify the config
```sh
$ docker run --rm -it -v $PWD:/mnt/ocio-config ayoburgess/ocio ociocheck --iconfig /mnt/ocio-config/config.ocio

OpenColorIO Library Version: 1.1.0
OpenColorIO Library VersionHex: 16842752
Loading /mnt/ocio-config/config.ocio

** General **
Search Path: luts
Working Dir: /mnt/ocio-config

Default Display: default
Default View: None

** Roles **
raw (default)
linear (scene_linear)
raw (data)
linear (reference)
Cineon (compositing_log)
Cineon (color_timing)
sRGB (color_picking)
sRGB (texture_paint)
sRGB (matte_paint)

** ColorSpaces **
linear
sRGB
sRGBf
rec709
Cineon
Gamma1.8
Gamma2.2
Panalog
REDLog
ViperLog
AlexaV3LogC
PLogLin
SLog
raw

** Looks **
no looks defined

** Sanity Check **
passed

Tests complete.
```