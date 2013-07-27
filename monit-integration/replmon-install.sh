#!/bin/bash
set -o errexit
set -o nounset

apt-get install -y python-dev python-setuptools python-pip
pip install replmon
