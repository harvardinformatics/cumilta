FROM debian:9.9-slim

ENV DEBIAN_FRONTEND noninteractive

# spherelib needs gsl < 2.0
# for some reason, waf install needs to be run twice to install all components
RUN apt update -y && apt install --no-install-recommends -y make wget python-healpy swig g++ \
                         libpython-dev libhealpix-cxx-dev libcfitsio-dev libeigen3-dev libfftw3-dev python-tk python-pyfits && \
    wget -O - ftp://ftp.gnu.org/gnu/gsl/gsl-1.16.tar.gz | tar -xzvf - && \
    (cd gsl-1.16 && ./configure && make && make install) && \
    wget --no-check-certificate -O - https://downloads.sourceforge.net/project/healpix/Healpix_3.30/healpix_cxx-3.30.0.tar.gz | tar -xzvf - && \
    wget --no-check-certificate -O - https://gitlab.in2p3.fr/spherelib/spherelib/-/archive/master/spherelib-master.tar.gz | tar -xzvf - && \
    cd spherelib-master/python && \
    sed -i -e 's/.*ctx.check_cxx.*cxxsupport.*//' -e 's/stlibs = .*cxxsupport.*/stlibs = ["healpix_cxx"]/' wscript && \
    CXXFLAGS='-I /usr/include/healpix_cxx/ -I/healpix_cxx-3.30.0/cxxsupport' LDFLAGS='-L/usr/lib/x86_64-linux-gnu/ -lhealpix_cxx' ./waf configure && \
    ./waf install && ./waf install && \
    apt remove -y make wget swig && \
    cd / && rm -rf spherelib-master healpix_cxx-* gsl-1.16 /var/lib/apt/lists/*

ENV PYTHONPATH=/usr/local:/usr/local/spherelib LD_LIBRARY_PATH=/usr/local/lib

ENTRYPOINT ["python"]
