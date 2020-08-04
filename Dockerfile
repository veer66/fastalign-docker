FROM debian:10
ENV LANG=C.UTF-8
ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone
RUN sed 's/deb.debian.org/mirror.kku.ac.th/g' /etc/apt/sources.list > /tmp/sources.list && mv /tmp/sources.list /etc/apt
RUN apt-get update
RUN apt-get upgrade -y && \
    apt-get install -y git cmake g++ libboost-all-dev
                   
#		   libz-dev libssl-dev zlib1g-dev libbz2-dev liblzma-dev \
#		   libprotobuf9v5 protobuf-compiler libprotobuf-dev \
#		   python3-dev python3-numpy python3-setuptools

RUN cd / && \
    git clone https://github.com/clab/fast_align.git && \
    cd fast_align && \
    git checkout cab1e9a && \
    cmake . && \
    make -j $(nproc) 
RUN cp /fast_align/fast_align /usr/local/bin
