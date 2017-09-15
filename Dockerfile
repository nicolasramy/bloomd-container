FROM alpine

RUN apk update && apk upgrade
RUN apk add scons \
    build-base \
    git

RUN mkdir /application

WORKDIR /application

RUN git clone https://github.com/armon/bloomd.git /application/
ADD bloomd.conf /etc/bloomd.conf

RUN scons && mv bloomd /usr/bin

RUN mkdir -p /var/lib/bloomd
VOLUME /var/lib/bloomd

EXPOSE 8673

CMD ["bloomd", "-f", "/etc/bloomd.conf", "2>&1"]
