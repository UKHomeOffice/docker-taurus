FROM quay.io/ukhomeofficedigital/python:v3.4.3
MAINTAINER Jon Shanks <jon.shanks@digital.homeoffice.gov.uk>

ENV TAURUS_VERSION 1.12.1

RUN yum install yum-plugin-remove-with-leaves -y && \
    yum install java-1.8.0-openjdk-headless.x86_64 python34-devel.x86_64 libxml2-devel.x86_64 \
                libxslt-devel.x86_64 zlib.x86_64 gcc.x86_64 -y

RUN pip install bzt

RUN yum remove python34-devel.x86_64 libxml2-devel.x86_64 libxslt-devel.x86_64 gcc.x86_64 --remove-leaves -y

ADD 99-zinstallID.json /etc/bzt.d/
ADD 90-artifacts-dir.json /etc/bzt.d/
ADD 90-no-console.json /etc/bzt.d/

RUN bzt -o settings.default-executor=jmeter -o execution.scenario.requests.0=http://localhost/ \
        -o execution.iterations=1 -o execution.hold-for=1 -o execution.throughput=1

VOLUME ["/bzt"]
WORKDIR /bzt

CMD bzt -l bzt.log /bzt/*.yml
