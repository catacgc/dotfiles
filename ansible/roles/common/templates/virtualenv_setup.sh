#!/bin/bash

BASEDIR={{ basedir }}
VIRTUAL_ENV_VERSION=1.9

mkdir -p $BASEDIR
pushd $BASEDIR

# download venv
curl -sO https://pypi.python.org/packages/source/v/virtualenv/virtualenv-$VIRTUAL_ENV_VERSION.tar.gz
tar xvfz virtualenv-$VIRTUAL_ENV_VERSION.tar.gz

# create default local python env
deactivate
pushd virtualenv-$VIRTUAL_ENV_VERSION
./virtualenv.py $BASEDIR/env
source $BASEDIR/env/bin/activate
popd