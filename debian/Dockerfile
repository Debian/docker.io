FROM tianon/debian:sid
MAINTAINER Tianon Gravi <admwiggin@gmail.com>

RUN apt-get update && apt-get install -yq devscripts git-buildpackage
RUN echo 'deb-src http://http.debian.net/debian sid main' >> /etc/apt/sources.list
ADD . /usr/src/docker-io/debian
WORKDIR /usr/src/docker-io
RUN apt-get update && mk-build-deps -irt'apt-get --no-install-recommends -yq' debian/control

RUN uscan --force-download --verbose --download-current-version
RUN origtargz --unpack

# tianon is _really_ lazy, and likes a preseeded bash history
RUN echo 'debuild -us -uc' >> /.bash_history

# TODO remove this once golang sqlite3 is properly packaged
RUN apt-get install -yq libsqlite3-dev mercurial

CMD [ "debuild", "-us", "-uc" ]
