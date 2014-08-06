#!/bin/bash

BASEDIR=~/.env
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

# install ansible
pip install ansible
pip install markupsafe

pushd $BASEDIR
# pull git repo
echo "localhost ansible_connection=local" > hosts
curl -L  https://github.com/catacgc/dotfiles/archive/master.tar.gz | tar -xz

# run full ansible recipies
ansible-playbook -i hosts dotfiles-master/ansible/site.yml -e basedir=$BASEDIR
popd
