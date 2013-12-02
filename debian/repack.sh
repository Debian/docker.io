#!/bin/sh
# Taken from the X Strike Force Build System

set -e

if ! [ -d debian/prune ]; then
	exit 0
fi

if [ "x$1" != x--upstream-version ]; then
	exit 1
fi

version="$2"
filename="$3"

if [ -z "$version" ] || ! [ -f "$filename" ]; then
	exit 1
fi

dir="$(pwd)"
tempdir="$(mktemp -d)"

cd "$tempdir"
tar xf "$dir/$filename"
cat "$dir"/debian/prune/* | while read file; do rm -rvf */$file; done

dfsgfilename="$(echo $filename | sed -E 's/(\.orig\.)/+dfsg1\1/')"
tar -czf ${dir}/${dfsgfilename} *
cd "$dir"
rm -rf "$tempdir"
echo "Done pruning upstream tarball into $dfsgfilename"

exit 0
