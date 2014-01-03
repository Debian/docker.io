FROM debian:sid
MAINTAINER Tianon Gravi <admwiggin@gmail.com>

RUN apt-get update && apt-get install -yq devscripts equivs libcrypt-ssleay-perl lintian --no-install-recommends
RUN echo 'deb-src http://http.debian.net/debian sid main' >> /etc/apt/sources.list
ADD . /usr/src/docker.io/debian
WORKDIR /usr/src/docker.io
RUN apt-get update && mk-build-deps -irt'apt-get --no-install-recommends -yq' debian/control

RUN uscan --force-download --verbose --download-current-version
RUN origtargz --unpack

# tianon is _really_ lazy, and likes a preseeded bash history
RUN (echo 'uscan --force-download --verbose --download-current-version' && echo 'origtargz --unpack && debuild -us -uc') >> /.bash_history

CMD [ "debuild", "-us", "-uc" ]
