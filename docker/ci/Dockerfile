FROM ubuntu:20.04 AS runtime
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get -y install libmumps-5.2.1 libgomp1 libtrilinos-ml12 libopenmpi3 libmetis5 openssh-client time \
 && apt-get -y install libmkl-core libmkl-intel-lp64 libmkl-gnu-thread libmkl-scalapack-lp64 libmkl-blacs-openmpi-lp64 \
 && apt-get clean \
 && echo >> /etc/openmpi/openmpi-mca-params.conf \
 && echo btl_vader_single_copy_mechanism=none >> /etc/openmpi/openmpi-mca-params.conf \
 && echo btl_openib_allow_ib=true >> /etc/openmpi/openmpi-mca-params.conf \
 && echo btl_openib_warn_default_gid_prefix=0 >> /etc/openmpi/openmpi-mca-params.conf \
 && rm -rf /var/lib/apt/lists/*

FROM runtime AS build
RUN apt-get update \
 && apt-get -y install  build-essential ccache cmake curl gfortran git libmetis-dev libmumps-dev libopenblas-dev libopenmpi-dev libptscotch-dev trilinos-all-dev libmkl-dev \
 && apt-get clean \
 && git clone --depth=1  https://gitlab.com/FrontISTR-Commons/REVOCAP_Mesh.git \
 && cd REVOCAP_Mesh \
 && cp config/MakefileConfig.LinuxCluster MakefileConfig.in \
 && make -j4 Refiner \
 && find lib -type f -name "libRcapRefiner*" -exec cp {} /usr/lib/ \; \
 && find . -type f -name "rcapRefiner.h" -exec cp {} /usr/include/ \; \
 && cd ../ && rm -fr ./REVOCAP_Mesh \
 && rm -rf /var/lib/apt/lists/*

FROM build AS build-metis4
RUN apt-get -y remove libmetis-dev libmetis5 \
 && curl -O http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/OLD/metis-4.0.3.tar.gz \
 && tar xvf metis-4.0.3.tar.gz \
 && cd metis-4.0.3 \
 && make -C Lib -j \
 && cp libmetis.a /usr/lib/ \
 && find Lib -name "*.h"|xargs -i cp {} /usr/include/

FROM build AS document
RUN apt-get update \
 && apt-get install -y doxygen graphviz python3 python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

