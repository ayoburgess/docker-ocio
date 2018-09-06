FROM centos:7

# yum installs
RUN yum update -y && yum -y install epel-release && yum install -y \
    gcc-c++ \
    make \
    cmake3 \
    python-devel \
    git

# OCIO
ARG OCIO_ROOT=/opt/ocio
ARG OCIO_VER=1.1.0
WORKDIR ${OCIO_ROOT}/src
RUN curl -O -L https://github.com/imageworks/OpenColorIO/archive/v${OCIO_VER}.tar.gz && \
    tar -xvzf v${OCIO_VER}.tar.gz && \
    cd OpenColorIO-${OCIO_VER} && \
    cmake3 . && \
    make && \
    make install
ENV LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
ENV PYTHONPATH=/usr/local/lib/python2.7/site-packages:${PYTHONPATH}

# cleanup
WORKDIR /
RUN rm -rf ${OCIO_ROOT} && \
    yum erase -y gcc-c++ make cmake3 python-devel git && \
    rm -rf /var/cache/yum && \
    hash -r
