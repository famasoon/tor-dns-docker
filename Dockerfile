FROM ubuntu:14.04

MAINTAINER FAMASoon

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install build-essential libevent-dev libssl-dev
RUN apt-get -y install git
RUN apt-get -y install python
RUN git clone https://github.com/0x3a/tor-dns
RUN cd tor-dns/patched\ tor/tor-0.2.6.1-alpha/ && \
    sh ./configure --disable-asciidoc && \
    make
RUN cp tor-dns/patched\ tor/tor-0.2.6.1-alpha/src/config/torrc.sample.in /torrc
RUN echo "Log notice file /notices.log" >> /torrc && \
    echo "DirPort 9030" >> /torrc
RUN tor-dns/patched\ tor/tor-0.2.6.1-alpha/src/or/tor -f /torrc &

EXPOSE 8081 9030
