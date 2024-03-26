FROM postgres:bullseye

VOLUME /init
WORKDIR /init

COPY ./build.sh /init
COPY ./init.sh /init
RUN bash ./build.sh

CMD ["bash", "init.sh"]