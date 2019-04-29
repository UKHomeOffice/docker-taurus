FROM alpine:3.9

ENV TAURUS_VERSION 1.12.1

RUN apk --update add \
    linux-headers \
    openjdk8 \
    python \
    python-dev \
    py-pip \
    libc-dev \
    libxml2-dev \
    libxslt-dev \
    zlib \
    gcc

RUN pip install --upgrade pip bzt
ADD 99-zinstallID.json /etc/bzt.d/
ADD 90-artifacts-dir.json /etc/bzt.d/
ADD 90-no-console.json /etc/bzt.d/

RUN bzt -o settings.default-executor=jmeter -o execution.scenario.requests.0=http://localhost/ \
        -o execution.iterations=1 -o execution.hold-for=1 -o execution.throughput=1

VOLUME ["/bzt"]
WORKDIR /bzt

RUN adduser -u 1000  -h /bzt -s /bin/ash -S taurus 

USER 1000

CMD bzt -l bzt.log /bzt/*.yml
