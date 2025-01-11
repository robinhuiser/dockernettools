FROM streamdal/plumber AS plumber

FROM alpine:latest

# Necessary dependencies
RUN apk --update add bash curl ca-certificates && update-ca-certificates

RUN apk add --update --no-cache  \
	--repository http://dl-3.alpinelinux.org/alpine/edge/main/ \
	mysql-client \
	postgresql-client \
	redis \
	curl \
	bind-tools \
	wget \
	openssh-client \
	bind-tools \
	iputils \
	jq \
	netcat-openbsd \
	net-tools \
	busybox-extras \
	vim \
	git \
	nano  \
	python3 py3-pip \
	bash \
	fortune \
	py3-pip \
	py3-setuptools

RUN apk add --update --no-cache  \
	--repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
	swaks 

RUN apk add --update --no-cache  \
	--repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
	yq jq

RUN apk add --update --no-cache  \
	--repository http://dl-cdn.alpinelinux.org/alpine/v3.9/community \
	--repository http://dl-cdn.alpinelinux.org/alpine/v3.9/main \
	mongodb yaml-cpp=0.6.2-r2 

# Install plumber binary
COPY --from=plumber /usr/bin/plumber /usr/bin/plumber

RUN  rm -rf /var/cache/apk/* \
	rm -r /root/.cache
RUN adduser -S user  -G root
USER user
WORKDIR /home/user

CMD ["sh", "-c", "tail -f /dev/null"]

