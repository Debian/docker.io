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
source="docker.io"


if [ -z "$version" ] || ! [ -f "$filename" ]; then
	exit 1
fi

dir="$(pwd)"
tempdir="$(mktemp -d)"

cd "$tempdir"
tar xf "$dir/$filename"
cat "$dir"/debian/prune/* | while read file; do rm -rvf */$file; done

tar -czf ${dir}/${filename} *
cd "$dir"
rm -rf "$tempdir"
echo "Done pruning upstream tarball"

exit 0
