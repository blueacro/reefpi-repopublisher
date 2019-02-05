#!/bin/bash

set -e

REPROPRO_OPTIONS="--keepunusednewfiles --keepunreferencedfiles"
S3_BUCKET="s3://repo.blueacro.com"
EXPORT_KEY="A6A0D5E1B393B1AB1DB4832F9A04AE4AAF5EA861"

if ! [ -d venv ]; then
    virtualenv venv
    venv/bin/pip install -r requirements.txt
fi

mkdir -p packages/
venv/bin/python github_get.py --output packages/

BASE=$PWD/build

rm -rf $BASE
mkdir -p $BASE
cp -r repos $BASE

reprepro ${REPREPRO_OPTIONS} --basedir ${BASE}/repos/reef-pi0 includedeb stretch packages/*pi0.deb
reprepro ${REPROPRO_PTIONS} --basedir ${BASE}/repos/reef-pi3 includedeb stretch packages/*pi3.deb

venv/bin/aws s3 sync --acl=public-read build/repos ${S3_BUCKET}/repos

gpg2 --export --armor ${EXPORT_KEY} > repo.key
venv/bin/aws s3 cp --acl=public-read repo.key ${S3_BUCKET}/repo.key
rm -f repo.key

venv/bin/aws s3 cp --acl=public-read setup.sh ${S3_BUCKET}/setup.sh
