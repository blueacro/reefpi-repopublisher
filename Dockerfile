FROM debian:stretch

RUN apt-get update && \
    apt-get install virtualenv reprepro python python3 -y

COPY requirements.txt /repopublisher/requirements.txt

WORKDIR /repopublisher

RUN virtualenv --python=python3 venv && \
    venv/bin/pip install -r requirements.txt

COPY . /repopublisher
