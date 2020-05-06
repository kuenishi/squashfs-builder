FROM ubuntu:20.04 as builder

RUN apt-get -y update
RUN apt install -y --no-install-recommends \
        git build-essential manpages manpages-dev \
        ca-certificates

RUN mkdir -p /usr/local/src
RUN git clone https://github.com/plougher/squashfs-tools.git /usr/local/src/squashfs-tools

WORKDIR /usr/local/src/squashfs-tools/squashfs-tools

RUN apt install -y --no-install-recommends \
        zlib1g zlib1g-dev \
        lz4 liblz4-1 liblz4-dev \
        zstd libzstd-dev \
        lzop liblzo2-dev \
        lzma liblzma-dev

RUN make -j all XZ_SUPPORT=1 LZO_SUPPORT=1 LZ4_SUPPORT=1 ZSTD_SUPPORT=1


FROM ubuntu:20.04

RUN apt-get update -y && apt install -y --no-install-recommends \
        zlib1g \
        lz4 liblz4-1 \
        zstd \
        lzop \
        lzma

COPY --from=builder /usr/local/src/squashfs-tools/squashfs-tools/mksquashfs /usr/local/bin/
COPY --from=builder /usr/local/src/squashfs-tools/squashfs-tools/unsquashfs /usr/local/bin/

RUN mkdir -p /workdir
WORKDIR /workdir
