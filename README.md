# Introduction
This project defines a [Docker](https://www.docker.com) image that contains [OpenColorIO](http://www.http://opencolorio.org/) command line utilities (ociocheck and ociobakelut) and python bindings (PyOpenColorIO).

# Installation
```
$ docker pull ayoburgess/ocio
```

# Usage
## Using python bindings to compile an OCIO config
```
$ git clone https://github.com/ayoburgess/cgi_aces_ocio.git
$ docker run --rm -it -v ${PWD}:/mnt/${PWD} ayoburgess/ocio python /mnt/${PWD}/cgi_aces_ocio/make.py

Wrote config_acescg.ocio successfully
Wrote config_linear_srgb.ocio successfully
```

## Verify one of the newly generated configs with ociocheck
```
$ docker run --rm -it -v ${PWD}:/mnt/${PWD} ayoburgess/ocio ociocheck --iconfig /mnt/${PWD}/cgi_aces_ocio/config_acescg.ocio

OpenColorIO Library Version: 1.1.0
OpenColorIO Library VersionHex: 16842752
Loading /mnt//home/ayo/workspace/github/cgi_aces_ocio/config_acescg.ocio

** General **
Search Path: luts:matrices
Working Dir: /mnt/home/ayo/workspace/github/cgi_aces_ocio

Default Display: default
Default View: ACES Rec. 709

** Roles **
Utility - Raw (default)
ACES - ACEScg (scene_linear)
Utility - Raw (data)
ACES - ACES2065-1 (reference)
ACES - ACEScct (compositing_log)
ACES - ACEScct (color_timing)
Utility - Raw (color_picking)
Utility - Raw (texture_paint)
Utility - Raw (matte_paint)
ACES - ACEScg (compositing_linear: user)
ACES - ACEScg (rendering: user)

** ColorSpaces **
ACES - ACES2065-1
ACES - ACEScg
ACES - ACESproxy
ACES - ACEScc
ACES - ACEScct
Input - Linear (sRGB)
Input - sRGB
Input - Rec. 709
Utility - Raw
Output - ACES Rec. 709
Output - ACES sRGB

** Looks **
no looks defined

** Sanity Check **
passed

Tests complete.
```
