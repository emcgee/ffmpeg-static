FROM ubuntu:16.04

# Basic packages needed to download dependencies and unpack them.
RUN apt-get update && apt-get install -y \
  bzip2 \
  perl \
  tar \
  wget \
  xz-utils \
  && rm -rf /var/lib/apt/lists/*

# Install packages necessary for compilation.
RUN apt-get update && apt-get install -y \
  autoconf \
  automake \
  bash \
  build-essential \
  cmake \
  curl \
  frei0r-plugins-dev \
  gawk \
  libfontconfig-dev \
  libfreetype6-dev \
  libopencore-amrnb-dev \
  libopencore-amrwb-dev \
  libsdl1.2-dev \
  libspeex-dev \
  libssl-dev \
  libtheora-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvo-amrwbenc-dev \
  libvorbis-dev \
  libwebp-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  libxvidcore-dev \
  lsb-release \
  pkg-config \
  sudo \
  tar \
  texi2html \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

VOLUME /ffmpeg-static
WORKDIR /ffmpeg-static

# x264 latest requires nasm > 2.13
RUN wget http://www.nasm.us/pub/nasm/releasebuilds/2.13.01/nasm-2.13.01.tar.gz \ 
  && tar -xf nasm-2.13.01.tar.gz && cd nasm-2.13.01 && ./configure && make install && rm -rf ../nasm-*

# Copy the build scripts.
COPY build.sh download.pl env.source fetchurl /ffmpeg-static/

CMD /bin/bash
