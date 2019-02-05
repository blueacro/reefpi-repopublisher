#!/bin/bash

set -e

BASE=$PWD/build

rm -rf $BASE
mkdir -p $BASE
cp -r repos $BASE

reprepro --basedir ${BASE}/repos/reef-pi0 includedeb stretch *pi0.deb
reprepro --basedir ${BASE}/repos/reef-pi3 includedeb stretch *pi3.deb

aws s3 sync --acl=public-read build/repos s3://repo.blueacro.com/repos

gpg2 --export --armor A6A0D5E1B393B1AB1DB4832F9A04AE4AAF5EA861 > repo.key
aws s3 cp --acl=public-read repo.key s3://repo.blueacro.com/repo.key
