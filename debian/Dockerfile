FROM tianon/debian-devel

# start by adding just "debian/control" so we can get mk-build-deps with maximum caching
ADD control /usr/src/docker.io/debian/
WORKDIR /usr/src/docker.io

# get all the build deps of _this_ package in a nice repeatable way
RUN apt-get update && mk-build-deps -irt'apt-get --no-install-recommends -yq' debian/control

# need our debian/ directory to compile _this_ package
ADD . /usr/src/docker.io/debian

# go download and unpack our upstream source
RUN uscan --force-download --verbose --download-current-version
RUN origtargz --unpack

# tianon is _really_ lazy, and likes a preseeded bash history
RUN echo 'origtargz --unpack && debuild -us -uc --lintian-opts "-EvIL+pedantic"' >> /root/.bash_history

CMD [ "debuild", "-us", "-uc", "--lintian-opts", "-EvIL+pedantic" ]
