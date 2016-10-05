#!/usr/bin/env bash

source /home/vagrant/.rvm/scripts/rvm # changed, used to be /usr/local/rvm/scripts/rvm

rvm use --default --install $1        # changed, used to not set --default

shift

if (( $# ))
  then gem install $@
fi
