FROM vurdalaque/build-env
# common build installation:
# apt-get update && apt-get -y --no-install-recommends install
#   	build-essential \
#   	gcc \
#   	g++ \
#   	cmake \
#   	ninja-build \
#   	curl \
#   	gettext \
#   	ca-certificates \
#   	git \
#   	git-lfs \

LABEL site.vendor="vurdalaque"
LABEL description="OCSERV build environment"

ENV HOME=/root
ENV GIT_SSL_NO_VERIFY=1

RUN apt-get update && apt-get -y --no-install-recommends install \
		libev-dev \
		libnl-3-dev \
		libcrypt-dev \
		libnl-route-3-dev \
		libsystemd-dev \
		libreadline-dev \
		libtalloc-dev \
		liblz4-dev \
		libgeoip-dev \
		libtasn1-6-dev \
		libtasn1-bin \
		libgnutls28-dev \
		nettle-dev \
		protobuf-c-compiler \
		gperf \
	&& apt-get autoremove && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/vurdalaque/ocserv-cmake.git $HOME/ocserv \
	&& mkdir $HOME/ocserv/.build \
	&& cd $HOME/ocserv/.build \
	&& cmake .. -DWITH_NL=ON -DWITH_M=ON -DWITH_SYSTEMD=ON -DWITH_NL=ON -DCAPTURE_LATENCY_SUPPORT=ON \
	&& cmake --build . --target install && rm -rf $HOME/ocserv





