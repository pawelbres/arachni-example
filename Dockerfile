FROM ubuntu:18.04 as builder

RUN cd /tmp \
    && apt-get update \
    && apt-get install -y wget \
    && wget -O /tmp/arachni.tar.gz https://github.com/Arachni/arachni/releases/download/v1.5.1/arachni-1.5.1-0.5.12-linux-x86_64.tar.gz \
    && tar -zxf arachni.tar.gz \
    && rm /tmp/arachni.tar.gz \
    && mv /tmp/arachni* /tmp/arachni \
    && rm -rf /var/lib/apt/lists/*

FROM ubuntu:18.04 as arachni_worker

WORKDIR /arachni

ENV SERVER_ROOT_PASSWORD arachni
ENV ARACHNI_USERNAME arachni
ENV ARACHNI_PASSWORD arachni
ENV DB_ADAPTER sqlite

COPY --from=0 /tmp/arachni /arachni

ENTRYPOINT bin/arachni_rpcd --address $(hostname -i)

FROM ubuntu:18.04 as arachni_server

WORKDIR /arachni

ENV SERVER_ROOT_PASSWORD arachni
ENV ARACHNI_USERNAME arachni
ENV ARACHNI_PASSWORD arachni
ENV DB_ADAPTER sqlite

COPY --from=0 /tmp/arachni /arachni

ENTRYPOINT bin/arachni_web --host $(hostname -i)
