FROM resin/rpi-raspbian:jessie

COPY . /facette
WORKDIR /facette

ENV PATH $PATH:/usr/local/go/bin:/go/bin

RUN apt-get update && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    librrd-dev \
    pandoc \
    npm \
    nodejs \
    build-essential \
    git-core && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    curl -s https://storage.googleapis.com/golang/go1.7.1.linux-armv6l.tar.gz | tar -C /usr/local -xz && \
    make && make install && \
    mkdir -p /etc/facette && \
    cp docs/examples/facette.json /etc/facette/facette.json && \
    mkdir -p /usr/share/facette && \
    mkdir -p /var/lib/facette && \
    mkdir -p /etc/facette/providers && \
    mkdir -p /var/run/facette && \
    chown -R 1:1 /usr/share/facette /var/lib/facette /etc/facette /var/run/facette && \
    apt-get remove --purge -y build-essential git-core && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}


USER 1
EXPOSE 12003
ENTRYPOINT ["facette"]
