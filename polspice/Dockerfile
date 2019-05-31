FROM centos:7.6.1810

RUN yum install -y epel-release && \
    yum install -y cmake3 make gcc-c++ numpy healpix-devel.x86_64 && \
    cd /tmp &&  \
    curl -L https://sourceforge.net/projects/healpix/files/Healpix_3.31/Healpix_3.31_2016Aug26.tar.gz | tar -xzf - && \
    mkdir -p /usr/local/lib/Healpix/ && \
    mv Healpix_3.31/data /usr/local/lib/Healpix && \
    curl ftp://ftp.iap.fr/pub/from_users/hivon/PolSpice/PolSpice_v03-05-01.tar.gz | tar -xzvf - && \
    mkdir PolSpice_v03-05-01/build && cd PolSpice_v03-05-01/build && \
    cmake3 -DHEALPIX_INCLUDE=/usr/lib64/gfortran/modules/healpix -DCFITSIO_LIBRARY=/usr/lib64/libcfitsio.so.2 .. && \
    make && \
    mv ../bin/spice /usr/local/bin && \
    cd /tmp && \
    rm -rf PolSpice_v03-05-01 Healpix_3.31 && \
    yum remove -y make cmake gcc-c++ && yum clean all

ENTRYPOINT ["spice"]
