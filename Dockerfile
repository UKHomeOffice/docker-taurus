FROM alpine:3.9

RUN mkdir -p /etc/bzt.d

ADD 99-zinstallID.json /etc/bzt.d/
ADD 90-artifacts-dir.json /etc/bzt.d/
ADD 90-no-console.json /etc/bzt.d/

RUN apk --update add \
                 openjdk8 \
                 python \
                 zlib \
                 py-pip && \
    apk --update add --virtual build-dependencies \
                 python-dev \
                 linux-headers \
                 libc-dev \
                 libxml2-dev \
                 libxslt-dev \
                 gcc && \
    pip install --upgrade pip bzt && \
    bzt -o settings.default-executor=jmeter -o execution.scenario.requests.0=http://localhost/ \
        -o execution.iterations=1 -o execution.hold-for=1 -o execution.throughput=1 && \
    apk del build-dependencies



VOLUME ["/bzt"]
WORKDIR /bzt

RUN adduser -u 1000  -h /bzt -s /bin/ash -S taurus 

USER 1000

CMD bzt -l bzt.log /bzt/*.yml
