FROM ubuntu:18.04 as builder

COPY ./arachni-1.5.1-0.5.12-linux-x86_64.tar.gz /tmp/arachni.tar.gz

RUN cd /tmp \
    && tar -zxf arachni.tar.gz \
    && rm /tmp/arachni.tar.gz \
    && mv /tmp/arachni* /tmp/arachni

FROM ubuntu:18.04 as arachni_worker

WORKDIR /arachni

ENV SERVER_ROOT_PASSWORD arachni
ENV ARACHNI_USERNAME arachni
ENV ARACHNI_PASSWORD arachni
ENV DB_ADAPTER sqlite

COPY --from=0 /tmp/arachni /arachni
#EXPOSE 9292

ENTRYPOINT ["bin/arachni_rpcd"]
CMD ["--address", "0.0.0.0"]


FROM ubuntu:18.04 as arachni_server

WORKDIR /arachni

ENV SERVER_ROOT_PASSWORD arachni
ENV ARACHNI_USERNAME arachni
ENV ARACHNI_PASSWORD arachni
ENV DB_ADAPTER sqlite

COPY --from=0 /tmp/arachni /arachni
#EXPOSE 7331

ENTRYPOINT ["bin/arachni_web"]
CMD ["--host", "0.0.0.0"]
