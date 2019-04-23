FROM debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y wget \
    gcc g++ make gfortran git cmake swig \
    libblas-dev liblapack-dev libbz2-dev libcurl4-openssl-dev libgsl-dev libfftw3-dev libeigen3-dev \
    python-dev python-setuptools python-pkg-resources cython python-numpy python-scipy python-astropy python-matplotlib

WORKDIR /usr/local

RUN wget http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio3450.tar.gz && \
    tar xvf cfitsio*.tar.gz && \
    (cd cfitsio* && ./configure --prefix=/usr/local && make && make install)

ENV PSHT_TARGET generic_gcc
RUN wget https://downloads.sourceforge.net/project/libpsht/Code/libpsht_20110131.tar.gz && \
    tar xvf libpsht*.tar.gz && \
    (cd libpsht* && make && cp generic_gcc/lib/* /usr/local/lib && cp generic_gcc/include/* /usr/local/include)

RUN wget ftp://ftp.gnu.org/gnu/gsl/gsl-1.16.tar.gz && \
    tar xvf gsl* && \
    (cd gsl* && ./configure && make && make install)

ENV PATH=/usr/local/PolSpice_v03-05-01/bin:$PATH
ENV PYTHONPATH=/usr/local/spherelib
